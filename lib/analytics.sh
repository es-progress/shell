# shellcheck shell=bash
################################################
## Analytics Functions Library                ##
##                                            ##
## Bash functions for statistics and analysis ##
################################################

## Analyze disk-usage
##
## @param    $1  Dir to check
## @default      Current working dir
####################################
anal-disk-usage() {
    local dir="${1:-.}"
    shift
    # shellcheck disable=SC2312
    du "${dir}" -hd1 "${@}" 2>/dev/null | sort -h
}
