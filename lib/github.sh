# shellcheck shell=bash
###########################
## GitHub Library        ##
##                       ##
## Wrapper for 'gh' tool ##
###########################

## List repos
##
## @param    $1  Owner (account)
## @param    $@  Extra args to gh
#################################
ghub-list() {
    local owner="${1:?Owner missing}"
    shift
    gh repo list "${owner}" --limit 100 "${@}"
}

## List repos with license info
##
## @param    $1  Owner (account)
## @param    $@  Extra args to gh
#################################
ghub-list-license() {
    local owner="${1:?Owner missing}"
    shift
    # shellcheck disable=SC2016
    ghub-list "${owner}" "${@}" \
        --json nameWithOwner,description,licenseInfo,visibility \
        --template '{{ tablerow ("NAME" | color "yellow+du") ("DESCRIPTION" | color "yellow+du") ("LICENSE" | color "yellow+du") ("VISIBILITY" | color "yellow+du") }}{{ range . }}{{ $lic := "---" }}{{ with .licenseInfo }}{{ $lic = .name }}{{ end }}{{ tablerow .nameWithOwner .description $lic .visibility }}{{ end }}'
}

## Get repo names
##
## @param    $1  Owner (account)
## @param    $@  Extra args to gh
#################################
ghub-get() {
    local owner="${1:?Owner missing}"
    shift
    # shellcheck disable=SC2312
    ghub-list "${owner}" "${@}" \
        --json nameWithOwner \
        --jq '.[].nameWithOwner' | LC_COLLATE=C sort -f
}

## Open repo in browser
##
## @param    $1  Repo
## @param    $@  Extra args to gh
#################################
ghub-open() {
    local repo="${1:-}"
    if [[ -z "${repo}" ]]; then
        gh browse
        return 0
    fi
    shift
    gh browse --repo "${repo}" "${@}"
}

## Open settings page in browser
##
## @param    $1  Repo
## @param    $@  Extra args to gh
#################################
ghub-settings() {
    local repo="${1:-}"
    if [[ -z "${repo}" ]]; then
        gh browse --settings
        return 0
    fi
    shift
    gh browse --repo "${repo}" --settings "${@}"
}

## Clone repo
##
## @param    $1  Repo
## @param    $@  Extra args to gh
#################################
ghub-repo-clone() {
    local repo="${1:?Repo missing}"
    shift
    gh repo clone "${repo}" "${@}"
}

## Create new repo
##
## @param    $1  Repo
## @param    $@  Extra args to gh
#################################
ghub-repo-new() {
    local repo="${1:?Repo missing}"
    shift
    gh repo create "${repo}" "${@}"
}

## Config repo
##
## @param    $1  Repo
## @param    $@  Extra args to gh
#################################
ghub-sync-config() {
    local repo="${1:?Repo missing}"
    shift
    gh repo edit "${repo}" \
        --delete-branch-on-merge \
        --enable-auto-merge=false \
        --enable-rebase-merge=false \
        --enable-squash-merge=false \
        --enable-projects=false \
        --enable-wiki=false "${@}"
}

## Sync labels from template
##
## @param    $1  Repo
## @param    $2  Master repo
############################
ghub-sync-labels() {
    local repo="${1:?Repo missing}"
    local template="${2:?Template missing}"
    local label labels_current labels_template exist_in_template

    # Sync labels
    labels_current=$(gh label list --repo "${repo}" --json name --jq '.[].name')
    labels_template=$(gh label list --repo "${template}" --json name)

    while IFS=$'\n\t' read -r label; do
        exist_in_template=$(jq -r "map(select(.name == \"${label}\")) | .[].name" <<<"${labels_template}")
        [[ -z "${exist_in_template}" ]] && gh label delete "${label}" --yes --repo "${repo}"
    done <<<"${labels_current}"

    gh label clone "${template}" --force --repo "${repo}"
}

## Add topic
##
## @param    $1  Repo
## @param    $@  Topics
#######################
ghub-topic() {
    local repo="${1:?Repo missing}"
    local topics=()
    shift

    for topic in "${@}"; do
        topics+=(--add-topic "${topic}")
    done

    if [[ -n "${topics[*]}" ]]; then
        gh repo edit "${repo}" "${topics[@]}"
    fi
}

## Create new private repo from template
##
## @param    $1  Repo
## @param    $2  Template repo
## @param    $@  Topics
################################
ghub-repo-template() {
    local repo="${1:?Repo missing}"
    local template="${2:?Template missing}"
    shift 2

    ghub-repo-new "${repo}" --private --template "${template}"
    ghub-sync-config "${repo}"
    ghub-sync-labels "${repo}" "${template}"
    ghub-topic "${repo}" "${@}"
    ghub-open "${repo}"
}

## Run command for each repo of owner
##
## @param    $1  Owner
## @param    $2  Command
## @param    $@  Extra args to command
######################################
ghub-foreach-owner() {
    local owner="${1:?Owner missing}"
    local command="${2:?Command missing}"
    local repo
    shift 2

    for repo in $(ghub-get "${owner}"); do
        "${command}" "${repo}" "${@}"
    done
}

## Run command for each repo of owner
## Repos filtered by topic
##
## @param    $1  Owner
## @param    $2  Topic
## @param    $3  Command
## @param    $@  Extra args to command
######################################
ghub-foreach-topic() {
    local owner="${1:?Owner missing}"
    local topic="${2:?Topic missing}"
    local command="${3:?Command missing}"
    local repo
    shift 3

    for repo in $(ghub-get "${owner}" --topic "${topic}"); do
        "${command}" "${repo}" "${@}"
    done
}

## Create issue in browser
##
## @param    $1  Repo
## @param    $@  Extra args to gh
#################################
ghub-issue() {
    local repo="${1:-}"
    if [[ -z "${repo}" ]]; then
        gh issue create --web
        return 0
    fi
    shift
    gh issue create --web --repo "${repo}" "${@}"
}

## Set repository secret for actions
##
## @param    $1  Repo
## @param    $2  Secret name
## @param    $3  Secret value
## @param    $@  Extra args to gh
####################################
ghub-secret-set() {
    local repo="${1:?Repo missing}"
    local name="${2:?Secret name missing}"
    local value="${3:?Secret value missing}"
    shift 3
    gh secret set "${name}" --body "${value}" --app actions --repo "${repo}" "${@}"
}

## Create PR in browser
##
## @param    $1  Title
## @param    $2  PR body: string or path to file
## @param    $@  Extra args to gh
################################################
ghub-pr() {
    local title="${1:?Title missing}"
    local body="${2:?PR body missing}"
    shift 2

    if [[ -r "${body}" ]]; then
        param_body=(--body-file "${body}")
    else
        param_body=(--body "${body}")
    fi

    gh pr create --assignee @me --web --title "${title}" "${param_body[@]}" "${@}"
}
