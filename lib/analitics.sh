# shellcheck shell=bash
################################################
## ES-Ubuntu                                  ##
##                                            ##
## Analitics Functions Library                ##
##                                            ##
## Bash functions for statistics and analysis ##
################################################

# Analize disk-usage
#
# @param    $1  Dir to check
# @default      Current working dir
###################################
anal-disk-usage(){
    local dir="${1:-"."}"
    shift
    du "${dir}" -hd1 "${@}" 2>/dev/null | sort -h
}
