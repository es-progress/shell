# shellcheck shell=bash
##################################
## ES-Ubuntu                    ##
##                              ##
## GitHub REST API Library      ##
##                              ##
## Interact with the GitHub API ##
## It needs 2 environment vars: ##
## - GH_USER: GitHub user name  ##
## - GH_TOKEN: GitHub token     ##
##################################

# Check connection
##################
gh-check-connection(){
    curl -w "\nStatus code: %{http_code}\n" https://api.github.com/zen
}

# Check authentication
######################
gh-check-auth(){
    status_code=$(curl -s -o /dev/null -w "%{http_code}" -u "${GH_USER}:${GH_TOKEN}" https://api.github.com/user)
    [[ "${status_code}" == "200" ]] && return 0 || return 1
}

# Get label
#
# @param    $1  Repo owner
# @param    $2  Repo name
# @param    $3  Label name
##########################
gh-labels-get(){
    local owner="${1:?"Owner missing"}"
    local repo="${2:?"Repo missing"}"
    local label="${3:?"Label name missing"}"
    curl \
        --silent -u "${GH_USER}:${GH_TOKEN}" \
        --url "https://api.github.com/repos/${owner}/${repo}/labels/${label}"
}

# Check if label exists
#
# @param    $1  Repo owner
# @param    $2  Repo name
# @param    $3  Label name
##########################
gh-labels-exists(){
    local owner="${1:?"Owner missing"}"
    local repo="${2:?"Repo missing"}"
    local label="${3:?"Label name missing"}"

    gh-labels-get "${owner}" "${repo}" "${label}" | jq -e .id >/dev/null
}

# List all labels for a repo
#
# @param    $1  Repo owner
# @param    $2  Repo name
############################
gh-labels-list(){
    local owner="${1:?"Owner missing"}"
    local repo="${2:?"Repo missing"}"

    curl \
        --silent -u "${GH_USER}:${GH_TOKEN}" \
        --url "https://api.github.com/repos/${owner}/${repo}/labels" | jq .
}

# Add a label to repo
# Create or update
#
# @param    $1  Repo owner
# @param    $2  Repo name
# @param    $3  Label data JSON
###############################
gh-labels-add(){
    local owner="${1:?"Owner missing"}"
    local repo="${2:?"Repo missing"}"
    local labels="${3:?"Label data JSON missing"}"
    local name

    name=$(echo "${labels}" | jq -r .name)

    if gh-labels-exists "${owner}" "${repo}" "${name}"; then
        echo "Update ${name}"
        curl \
            --silent -u "${GH_USER}:${GH_TOKEN}" \
            -X PATCH \
            -d "${labels}" \
            --url "https://api.github.com/repos/${owner}/${repo}/labels/${name}"
    else
        echo "Create ${name}"
        curl \
            --silent -u "${GH_USER}:${GH_TOKEN}" \
            -X POST \
            -d "${labels}" \
            --url "https://api.github.com/repos/${owner}/${repo}/labels"
    fi
}

# Add multiple label to repo from file
#
# @param    $1  Repo owner
# @param    $2  Repo name
# @param    $3  Labels JSON file
######################################
gh-labels-add-multiple(){
    local owner="${1:?"Owner missing"}"
    local repo="${2:?"Repo missing"}"
    local labels_file="${3:?"Labels file missing"}"

    labels=$(read-file-json "${labels_file}")
    local IFS=$'\n\t'
    for row in $labels; do
        gh-labels-add "${owner}" "${repo}" "${row}"
    done
}

# Delete a label
#
# @param    $1  Repo owner
# @param    $2  Repo name
# @param    $3  Label name
##########################
gh-labels-delete(){
    local owner="${1:?"Owner missing"}"
    local repo="${2:?"Repo missing"}"
    local label="${3:?"Label name missing"}"
    curl \
        --silent -u "${GH_USER}:${GH_TOKEN}" \
        -X DELETE \
        --url "https://api.github.com/repos/${owner}/${repo}/labels/${label}"
}

# Delete all labels for a repo
#
# @param    $1  Repo owner
# @param    $2  Repo name
##############################
gh-labels-delete-all(){
    local owner="${1:?"Owner missing"}"
    local repo="${2:?"Repo missing"}"

    labels=$(gh-labels-list "${owner}" "${repo}" | jq -rM .[].name)

    for label in $labels; do
        gh-labels-delete "${owner}" "${repo}" "${label}"
    done
}

# List public SSH keys for user
###############################
gh-sshkeys-list(){
    curl \
        --silent -u "${GH_USER}:${GH_TOKEN}" \
        --url https://api.github.com/user/keys | jq .[]
}

# Get public SSH key
#
# @param    $1  Title of key
# @param    $2  Filter field (optional)
#
# @return   Value of filter field or all fields
###############################################
gh-sshkeys-get(){
    local title="${1?:"Title missing"}"
    local filter="${2:-}"
    gh-sshkeys-list "${title}" | jq -r "select(.title == \"${title}\") | .${filter}"
}

# Delete public SSH key
#
# @param    $1  Key ID
#######################
gh-sshkeys-delete() {
    local key_id="${1?:"Key ID missing"}"
    curl \
        --silent -u "${GH_USER}:${GH_TOKEN}" \
        -X DELETE \
        --url "https://api.github.com/user/keys/${key_id}"
}

# Create public SSH key
#
# @param    $1  Title of key
# @param    $2  Public key
############################
gh-sshkeys-create() {
    local title="${1?:"Title missing"}"
    local key="${2?:"Key missing"}"
    curl \
        --silent -u "${GH_USER}:${GH_TOKEN}" \
        -X POST \
        -d "$(printf '{"title":"%s","key":"%s"}' "${title}" "${key}")" \
        --url https://api.github.com/user/keys
}
