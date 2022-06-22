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
    local owner="${1?:"Owner missing"}"
    shift
    gh repo list "${owner}" --limit 100 "${@}"
}

## Get repo names
##
## @param    $@  Owners (account)
#################################
ghub-get() {
    for owner in "${@}"; do
        # shellcheck disable=SC2312
        gh repo list "${owner}" --json nameWithOwner --jq ".[].nameWithOwner" | sort
    done
}

## Open repo in browser
##
## @param    $1  Repo
## @param    $@  Extra args to gh
#################################
ghub-open() {
    local repo="${1?:"Repo missing"}"
    shift
    gh browse --repo "${repo}" "${@}"
}

## Open settings page in browser
##
## @param    $1  Repo
## @param    $@  Extra args to gh
#################################
ghub-settings() {
    local repo="${1?:"Repo missing"}"
    shift
    ghub-open "${repo}" --settings "${@}"
}

## Create new repo
##
## @param    $1  Repo
## @param    $@  Extra args to gh
#################################
ghub-repo-new() {
    local repo="${1?:"Repo missing"}"
    shift
    gh repo create "${repo}" "${@}"
}

## Sync repo config from template
##
## @param    $1  Repo
## @param    $2  Template repo
## @param    $@  Extra args to gh
#################################
ghub-sync() {
    local repo="${1?:"Repo missing"}"
    local template="${2?:"Template missing"}"
    local label labels_current labels_template exist_in_template
    shift 2

    gh repo edit "${repo}" \
        --delete-branch-on-merge \
        --enable-auto-merge=false \
        --enable-rebase-merge=false \
        --enable-squash-merge=false \
        --enable-projects=false \
        --enable-wiki=false || return 1

    # Sync labels
    labels_current=$(gh label list --repo "${repo}" --json name --jq '.[].name')
    labels_template=$(gh label list --repo "${template}" --json name)

    while IFS=$'\n\t' read -r label; do
        exist_in_template=$(jq -r "map(select(.name == \"${label}\")) | .[].name" <<<"${labels_template}")
        [[ -z "${exist_in_template}" ]] && gh label delete "${label}" --confirm --repo "${repo}"
    done <<<"${labels_current}"

    gh label clone "${template}" --force --repo "${repo}"
}

## Add topic
##
## @param    $1  Repo
## @param    $@  Topics
#######################
ghub-topic() {
    local repo="${1?:"Repo missing"}"
    local topics=()
    shift

    for topic in "${@}"; do
        topics+=(--add-topic "${topic}")
    done

    if [[ -n "${topics[*]}" ]]; then
        gh repo edit "${repo}" "${topics[@]}"
    fi
}

## Create new repo from template
##
## @param    $1  Repo
## @param    $2  Template repo
## @param    $@  Topics
################################
ghub-repo-template() {
    local repo="${1?:"Repo missing"}"
    local template="${2?:"Template missing"}"
    shift 2

    ghub-repo-new "${repo}" --private --template "${template}"
    ghub-sync "${repo}" "${template}"
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
    local owner="${1?:"Owner missing"}"
    local command="${2?:"Command missing"}"
    local repo repos
    shift 2

    repos=$(ghub-get "${owner}")
    for repo in ${repos}; do
        "${command}" "${repo}" "${@}"
    done
}
