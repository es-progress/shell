# shellcheck shell=bash
####################################
## ES-Ubuntu                      ##
##                                ##
## Git Functions Library          ##
##                                ##
## Bash helper functions for git  ##
####################################

# Merge source branch into main and push
# Then delete local and remote tracking branch
#
# @param    $1  Branch to be merged
# @param    $2  Branch to merge into
# @default      main
##############################################
esgit-merge(){
    local branch="${1?:"Source branch missing"}"
    local into="${2:-"main"}"

    git fetch "origin"
    git checkout "${into}"
    git merge --no-ff "${branch}" || return 1
    git push "origin" "${into}" || return 1
    git branch -d "${branch}"
    git branch -d -r "origin/${branch}"
}

# Check git repo status
#######################
esgit-report(){
    print-header "Git status"
    git status || return 1

    print-header "Branches"
    git branch -a -l -vv

    print-header "Remotes"
    git remote -v
}

# Interactive rebase
# @param    $1  How many commits from HEAD
##########################################
esgit-base(){
    local commits="${1?:"Commits missing"}"
    git rebase -i "HEAD~${commits}"
}

# Pull main branch
##################
esgit-pull(){
    git checkout main
    git pull origin main
}

# Show commits
##############
esgit-log(){
    git --no-pager log --format="oneline"
}

# Statistics
# Daily commits
###############
esgit-stat-daily(){
    local user=$(git config --get --global user.name)

    echo "Commits | Hour of day"
    echo "--------+------------"
    git \
        --no-pager log \
        --author="${user}" \
        --format="%ad" \
        --date="format:%H" \
        | sort \
        | uniq -c \
        | awk '{printf("%7s | %-12s\n",$1,$2)}'
}

# Statistics
# Weekly commits
################
esgit-stat-weekly(){
    local user=$(git config --get --global user.name)

    echo "Commits | Weekday (1=Monday)"
    echo "--------+-------------------"
    git \
        --no-pager log \
        --author="${user}" \
        --format="%ad" \
        --date="format:%u" \
        | sort \
        | uniq -c \
        | awk '{printf("%7s | %-12s\n",$1,$2)}'
}

# Statistics
# Monthly commits
#################
esgit-stat-monthly(){
    local user=$(git config --get --global user.name)

    echo "Commits | Day of month"
    echo "--------+-------------"
    git \
        --no-pager log \
        --author="${user}" \
        --format="%ad" \
        --date="format:%d" \
        | sort \
        | uniq -c \
        | awk '{printf("%7s | %-12s\n",$1,$2)}'
}
