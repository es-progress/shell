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
###############################################
ggit-merge(){
    local branch="${1?:"Source branch missing"}"
    local into="${2:-"main"}"

    print-header "Pull remote changes for ${branch}"
    git checkout "${branch}"
    git pull origin "${branch}" || return 1
    print-header "Pull remote changes for ${into}"
    git checkout "${into}"
    git pull origin "${into}" || return 1
    print-header "Merge and push"
    git merge --no-ff "${branch}" -m "Merge branch '${branch}' into ${into}" || return 1
    git push "origin" "${into}" || return 1
    print-header "Delete branches"
    git branch -d "${branch}"
    git branch -d -r "origin/${branch}"
}

## Check git repo status
########################
ggit-report(){
    print-header "Git status"
    git status || return 1
    print-header "Branches"
    git branch -a -l -vv
    print-header "Remotes"
    git remote -v
}

## Interactive rebase (change history)
##
## @param    $1  How many commits from HEAD
###########################################
ggit-fix(){
    local commits="${1?:"Commits missing"}"
    git rebase -i "HEAD~${commits}"
}

## Pull main branch
##
## @param    $1  Branch
## @default      main
#######################
ggit-pull(){
    local branch="${1:-"main"}"
    print-header "Switch to ${branch}"
    git checkout "${branch}" || return 1
    print-header "Pull remote changes for ${branch}"
    git pull origin "${branch}" || return 1
    git submodule update --init
}

## Diff stat
##
## @param    $1  Branch A
## @param    $2  Branch B
#########################
ggit-diff(){
    local branch_a="${1?:"Branch A missing"}"
    local branch_b="${2?:"Branch B missing"}"
    git diff --stat "${branch_a}" "${branch_b}"
}

## Commit CiviCRM extension
##
## @param   $*  Extension dirs
##############################
ggit-commit(){
    local version key
    for arg; do
        key=$(sed -n '/extension key/ p' "${arg}/info.xml"| sed -r 's@^<extension key="(.*)" type="module">$@\1@')
        version=$(sed -n '/<version>/ p' "${arg}/info.xml"| sed -r 's@^\s*<version>(.*)</version>@\1@')
        git commit -m "${key} v${version}" "${arg}"
    done
}

## Rebase branch
##
## @param    $1  Branch to rebase
## @param    $2  Rebase onto this branch
## @default      main
########################################
ggit-base(){
    local branch_src="${1?:"Branch to rebase missing"}"
    local branch_onto="${2:-"main"}"
    print-header "Switch to ${branch_src}"
    git switch "${branch_src}" || return 1
    print-header "Rebase ${branch_src} onto ${branch_onto}"
    git rebase "${branch_onto}" || return 1
    print-header "Push ${branch_src}"
    git push origin "+${branch_src}" || return 1
    print-header "Switch to ${branch_onto}"
    git switch "${branch_onto}" || return 1
}

## Show log graphically
#######################
ggit-adog(){
    git log --all --decorate --oneline --graph
}

## Statistics
## Daily commits
################
ggit-stat-daily(){
    local user=$(git config --get --global user.name)

    echo "Commits | Hour of day"
    echo "--------+------------"
    git --no-pager log \
        --author="${user}" \
        --format="%ad" \
        --date="format:%H" \
        | sort \
        | uniq -c \
        | awk '{printf("%7s | %-12s\n",$1,$2)}'
}

## Statistics
## Weekly commits
#################
ggit-stat-weekly(){
    local user=$(git config --get --global user.name)

    echo "Commits | Weekday (1=Monday)"
    echo "--------+-------------------"
    git --no-pager log \
        --author="${user}" \
        --format="%ad" \
        --date="format:%u" \
        | sort \
        | uniq -c \
        | awk '{printf("%7s | %-12s\n",$1,$2)}'
}

## Statistics
## Monthly commits
##################
ggit-stat-monthly(){
    local user=$(git config --get --global user.name)

    echo "Commits | Day of month"
    echo "--------+-------------"
    git --no-pager log \
        --author="${user}" \
        --format="%ad" \
        --date="format:%d" \
        | sort \
        | uniq -c \
        | awk '{printf("%7s | %-12s\n",$1,$2)}'
}
