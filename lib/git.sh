# shellcheck shell=bash
####################################
## ES-Ubuntu                      ##
##                                ##
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
esgit-merge(){
    local branch="${1?:"Source branch missing"}"
    local into="${2:-"main"}"

    print-header "Pull remote changes for source branch"
    git checkout "${branch}"
    git pull origin "${branch}" || return 1
    print-header "Pull remote changes for target branch"
    git checkout "${into}"
    git pull origin "${into}" || return 1
    print-header "Merge and push"
    git merge --no-ff "${branch}" || return 1
    git push "origin" "${into}" || return 1
    print-header "Delete branches"
    git branch -d "${branch}"
    git branch -d -r "origin/${branch}"
}

## Check git repo status
########################
esgit-report(){
    print-header "Git status"
    git status || return 1
    print-header "Branches"
    git branch -a -l -vv
    print-header "Remotes"
    git remote -v
}

## Interactive rebase
## @param    $1  How many commits from HEAD
###########################################
esgit-base(){
    local commits="${1?:"Commits missing"}"
    git rebase -i "HEAD~${commits}"
}

## Pull main branch
##
## @param    $1  Branch
## @default      main
#######################
esgit-pull(){
    local branch="${1:-"main"}"
    git checkout "${branch}" || return 1
    git pull origin "${branch}" || return 1
    git submodule update --init
}

## Statistics
## Daily commits
################
esgit-stat-daily(){
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
esgit-stat-weekly(){
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
esgit-stat-monthly(){
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
