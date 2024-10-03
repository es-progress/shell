# shellcheck shell=bash
####################################
## Git Functions Library          ##
##                                ##
## Bash helper functions for git  ##
####################################

## Merge source branch into main and push
## then delete local and remote tracking branch
##
## @param    $1  Branch to be merged
## @param    $2  Branch to merge into
## @default      main
## @param    $3  Remote
## @default      origin
###############################################
ggit-merge() {
    local branch="${1?:Source branch missing}"
    local into="${2:-main}"
    local remote="${3:-origin}"

    print-header Pull remote changes for "${branch}" from "${remote}"
    git checkout "${branch}" || return 1
    git pull --stat "${remote}" "${branch}" || return 1
    print-header Pull remote changes for "${into}" from "${remote}"
    git checkout "${into}" || return 1
    git pull --stat "${remote}" "${into}" || return 1
    print-header Merge and push
    git merge --stat --no-ff "${branch}" -m "Merge branch '${branch}' into ${into}" || return 1
    git push "${remote}" "${into}" || return 1
    print-header Delete branches
    git branch -d "${branch}"
    git branch -d -r "${remote}/${branch}"
}

## Check git repo status
########################
ggit-report() {
    print-header Git status
    git status || return 1
    print-header Branches
    git --no-pager branch -a -l -vv
    print-header Remotes
    git --no-pager remote -v
}

## Interactive rebase (change history)
##
## @param    $1  How many commits from HEAD
###########################################
ggit-fix() {
    local commits="${1?:Commits missing}"
    git rebase -i "HEAD~${commits}"
}

## Pull main branch
##
## @param    $1  Branch
## @default      main
## @param    $2  Remote
## @default      origin
#######################
ggit-pull() {
    local branch="${1:-main}"
    local remote="${2:-origin}"

    print-header Switch to "${branch}"
    git checkout "${branch}" || return 1
    print-header Pull remote changes for "${branch}" from "${remote}"
    git pull "${remote}" "${branch}" || return 1
    git submodule update --init
}

## Update local branch from remote
##
## @param    $1  Branch
## @param    $2  Remote
## @default      origin
##################################
ggit-update() {
    local branch="${1?:Branch missing}"
    local remote="${2:-origin}"

    print-header Fetch "${remote}"
    git fetch --prune "${remote}" || return 1
    print-header Delete old "${branch}"
    git checkout -b "${branch}-temp" "${branch}" || return 1
    git branch -D "${branch}" || return 1
    print-header Checkout new "${branch}" from "${remote}"
    git checkout -b "${branch}" --recurse-submodules --track "${remote}/${branch}" || return 1
    git branch -D "${branch}-temp"
}

## Diff stat
##
## @param    $1  Branch A
## @param    $2  Branch B
#########################
ggit-diff() {
    local branch_a="${1?:Branch A missing}"
    local branch_b="${2?:Branch B missing}"
    git diff --stat "${branch_a}" "${branch_b}"
}

## Rebase branch
##
## @param    $1  Branch to rebase
## @param    $2  Rebase onto this branch
## @default      main
## @param    $3  Remote
## @default      origin
########################################
ggit-base() {
    local branch_src=("${1?:Branch to rebase missing}")
    local branch_onto="${2:-main}"
    local remote="${3:-origin}"
    local branch

    # If more than 3 arguments supplied
    # last 2 arguments are branch_onto and remote the rest are branch_src
    if [[ $# -gt 3 ]]; then
        branch_onto="${*: -2:1}"
        remote="${*: -1}"
        branch_src=("${@:1:$#-2}")
    fi

    for branch in "${branch_src[@]}"; do
        print-header Switch to "${branch}"
        git checkout "${branch}" || return 1
        print-header Rebase "${branch}" onto "${branch_onto}"
        git rebase "${branch_onto}" || return 1
        print-header Push "${branch}"
        git push "${remote}" "+${branch}" || return 1
    done
    print-header Switch to "${branch_onto}"
    git checkout "${branch_onto}" || return 1
}

## Create tag & push
##
## @param    $1  Tag name
## @param    $2  Commit to tag
## @default      HEAD
## @param    $3  Tag message
## @default      same as tag name
## @param    $4  Remote
## @default      origin
#################################
ggit-tag() {
    local name="${1?:Tag name missing}"
    local commit="${2:-HEAD}"
    local message="${3:-${name}}"
    local remote="${4:-origin}"

    git tag -s -m"${message}" "${name}" "${commit}" || return 1
    git push "${remote}" "${name}"
}

## Create bumped version tag (from last tag)
##
## @param    $1  Which part to bump (major, minor, patch)
## @param    $2  Commit to tag
## @default      HEAD
## @param    $3  Remote
## @default      origin
#########################################################
ggit-version() {
    local part="${1?:Version part missing}"
    local commit="${2:-HEAD}"
    local remote="${3:-origin}"
    local version

    version=$(git tag --list "v*" --sort=-v:refname | head -n1 | sed -r 's@v(.*)@\1@g' || true)
    if ! version=$(bump-version "${version}" "${part}"); then
        return 1
    fi

    ggit-tag "v${version}" "${commit}" "v${version}" "${remote}"
}

## Show log graphically
#######################
ggit-adog() {
    git log --all --decorate --oneline --graph
}

## Create patch from commit and apply
##
## @param   $*  Commit SHA
#####################################
ggit-patch() {
    local commit
    for commit in "${@}"; do
        # shellcheck disable=SC2312
        git format-patch --stdout -1 "${commit}" | git am
    done
}

## Statistics
## Daily commits
##
## @param   $1  Count commits after this date
## @param   $2  Count commits before this date
##############################################
ggit-stat-daily() {
    local after="${1:-}"
    local before="${2:-}"
    local date_filter=()
    local user

    user=$(git config --get --global user.name)

    [[ -n "${after}" ]] && date_filter=(--after="${after}")
    [[ -n "${before}" ]] && date_filter=("${date_filter[@]}" --before="${before}")

    echo "Hour of day | Commits"
    echo "------------+--------"
    # shellcheck disable=SC2312
    git --no-pager log \
        --author="${user}" \
        --format=%ad \
        --date=format:%H "${date_filter[@]}" \
        | sort \
        | uniq -c \
        | awk '{printf("%11s | %6s\n",$2,$1)}'
}

## Statistics
## Weekly commits
##
## @param   $1  Count commits after this date
## @param   $2  Count commits before this date
##############################################
ggit-stat-weekly() {
    local after="${1:-}"
    local before="${2:-}"
    local date_filter=()
    local user

    user=$(git config --get --global user.name)

    [[ -n "${after}" ]] && date_filter=(--after="${after}")
    [[ -n "${before}" ]] && date_filter=("${date_filter[@]}" --before="${before}")

    echo "Weekday (1=Monday) | Commits"
    echo "-------------------+--------"
    # shellcheck disable=SC2312
    git --no-pager log \
        --author="${user}" \
        --format=%ad \
        --date=format:%u "${date_filter[@]}" \
        | sort \
        | uniq -c \
        | awk '{printf("%18s | %6s\n",$2,$1)}'
}

## Statistics
## Monthly commits
##
## @param   $1  Count commits after this date
## @param   $2  Count commits before this date
##############################################
ggit-stat-monthly() {
    local after="${1:-}"
    local before="${2:-}"
    local date_filter=()
    local user

    user=$(git config --get --global user.name)

    [[ -n "${after}" ]] && date_filter=(--after="${after}")
    [[ -n "${before}" ]] && date_filter=("${date_filter[@]}" --before="${before}")

    echo "Day of month | Commits"
    echo "-------------+--------"
    # shellcheck disable=SC2312
    git --no-pager log \
        --author="${user}" \
        --format=%ad \
        --date=format:%d "${date_filter[@]}" \
        | sort \
        | uniq -c \
        | awk '{printf("%12s | %6s\n",$2,$1)}'
}
