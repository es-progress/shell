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
    local branch="${1?:"Source branch missing"}"
    local into="${2:-main}"
    local remote="${3:-origin}"

    print-header "Pull remote changes for ${branch} from ${remote}"
    git checkout "${branch}"
    git pull "${remote}" "${branch}" || return 1
    print-header "Pull remote changes for ${into} from ${remote}"
    git checkout "${into}"
    git pull "${remote}" "${into}" || return 1
    print-header "Merge and push"
    git merge --no-ff "${branch}" -m "Merge branch '${branch}' into ${into}" || return 1
    git push "${remote}" "${into}" || return 1
    print-header "Delete branches"
    git branch -d "${branch}"
    git branch -d -r "${remote}/${branch}"
}

## Check git repo status
########################
ggit-report() {
    print-header "Git status"
    git status || return 1
    print-header Branches
    git branch -a -l -vv
    print-header Remotes
    git remote -v
}

## Interactive rebase (change history)
##
## @param    $1  How many commits from HEAD
###########################################
ggit-fix() {
    local commits="${1?:"Commits missing"}"
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

    print-header "Switch to ${branch}"
    git checkout "${branch}" || return 1
    print-header "Pull remote changes for ${branch} from ${remote}"
    git pull "${remote}" "${branch}" || return 1
    git submodule update --init
}

## Diff stat
##
## @param    $1  Branch A
## @param    $2  Branch B
#########################
ggit-diff() {
    local branch_a="${1?:"Branch A missing"}"
    local branch_b="${2?:"Branch B missing"}"
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
    local branch_src="${1?:"Branch to rebase missing"}"
    local branch_onto="${2:-main}"
    local remote="${3:-origin}"

    print-header "Switch to ${branch_src}"
    git switch "${branch_src}" || return 1
    print-header "Rebase ${branch_src} onto ${branch_onto}"
    git rebase "${branch_onto}" || return 1
    print-header "Push ${branch_src}"
    git push "${remote}" "+${branch_src}" || return 1
    print-header "Switch to ${branch_onto}"
    git switch "${branch_onto}" || return 1
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
################
ggit-stat-daily() {
    local user
    user=$(git config --get --global user.name)

    echo "Commits | Hour of day"
    echo "--------+------------"
    # shellcheck disable=SC2312
    git --no-pager log \
        --author="${user}" \
        --format=%ad \
        --date="format:%H" \
        | sort \
        | uniq -c \
        | awk '{printf("%7s | %-12s\n",$1,$2)}'
}

## Statistics
## Weekly commits
#################
ggit-stat-weekly() {
    local user
    user=$(git config --get --global user.name)

    echo "Commits | Weekday (1=Monday)"
    echo "--------+-------------------"
    # shellcheck disable=SC2312
    git --no-pager log \
        --author="${user}" \
        --format=%ad \
        --date="format:%u" \
        | sort \
        | uniq -c \
        | awk '{printf("%7s | %-12s\n",$1,$2)}'
}

## Statistics
## Monthly commits
##################
ggit-stat-monthly() {
    local user
    user=$(git config --get --global user.name)

    echo "Commits | Day of month"
    echo "--------+-------------"
    # shellcheck disable=SC2312
    git --no-pager log \
        --author="${user}" \
        --format=%ad \
        --date="format:%d" \
        | sort \
        | uniq -c \
        | awk '{printf("%7s | %-12s\n",$1,$2)}'
}
