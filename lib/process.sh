# shellcheck shell=bash
###################################
## Processes & running           ##
##                               ##
## Functions regarding processes ##
###################################

## Check if run as root
#######################
check-root(){
    if [[ $(id -u) -ne 0 ]]; then
        print-error "Run as root!"
        return 1
    fi
    return 0
}

## Check if not run as root
###########################
check-not-root(){
    if [[ $(id -u) -eq 0 ]]; then
        print-error "Don't run as root!"
        return 1
    fi
    return 0
}

## Run command in each sub directory
##
## @param    $*  Command to run
## @default  ls
####################################
foreach-subdir(){
    dirs=$(find . -mindepth 1 -maxdepth 1 -type d | sort)
    for dir in ${dirs}; do
        print-section "${dir}"
        (
            cd "${dir}" || return 1
            ${*:-ls}
        )
    done
}

## Run command in each sub directory
##
## @param    $1  Command to run
## @param    $2  Command to pipe to
####################################
foreach-subdir-pipe(){
    local command="${1?:"Command missing"}"
    local pipe="${2?:"Pipe command missing"}"
    dirs=$(find . -mindepth 1 -maxdepth 1 -type d | sort)
    for dir in ${dirs}; do
        print-section "${dir}"
        (
            cd "${dir}" || return 1
            ${command} | ${pipe}
        )
    done
}

## Check if a command is running
##
## @param    $1  Command name
################################
proc-is-running(){
    local command="${1?:"Command missing"}"
    shift
    pgrep -f "${@}" "${command}" >/dev/null 2>&1
}

## Check if command exists
## @param    $@  Command
##########################
command-exists(){
    command -v "${@}" >/dev/null 2>&1
}
