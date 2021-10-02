# shellcheck shell=bash
###################################
## ES-Ubuntu                     ##
##                               ##
## Processes & running           ##
##                               ##
## Functions regarding processes ##
###################################

# Run command in each sub directory
#
# @param    $*  Command to run
# @default  ls
###################################
foreach-subdir(){
    for dir in *; do
        [[ -d "${dir}" ]] || continue
        print-header "${dir}"
        (
            cd "${dir}" || return 1
            ${*:-ls}
        )
    done
}

# Run command in each sub directory
#
# @param    $1  Command to run
# @param    $2  Command to pipe to
###################################
foreach-subdir-pipe(){
    local command="${1?:"Command missing"}"
    local pipe="${2?:"Pipe command missing"}"
    for dir in *; do
        [[ -d "${dir}" ]] || continue
        print-header "${dir}"
        (
            cd "${dir}" || return 1
            ${command} | ${pipe}
        )
    done
}

# Check if a command is running
#
# @param    $1  Command name
###############################
proc-is-running(){
    local command="${1?:"Command missing"}"
    shift
    pgrep -f "${@}" "${command}" >/dev/null 2>&1
}

# Check if command exists
# @param    $@  Command
#########################
command-exists() {
    command -v "${@}" >/dev/null 2>&1
}
