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
# @param    $1  Command to run
# @default      `ls`
# @param    $2  Parent directory
# @default      Current dir
###################################
foreach-subdir(){
    local command="${1:-ls}"
    local subdirs=$(ls -1 -d  -- ${2:-}*/)

    for dir in ${subdirs[*]}; do
        print-header "${dir}"
        (
            cd "${dir}" || return 1
            $command
        )
    done
}

# Check if a command is running
#
# @param    $1  Command name
###############################
proc-is-running(){
    if [[ $# -lt 1 ]]; then
        echo "Missing command"
        return 2
    fi
    pgrep -f "${*}" >/dev/null 2>&1
}

# Check if command exists
# @param    $*  Command
#########################
command-exists() {
    command -v "$@" >/dev/null 2>&1
}
