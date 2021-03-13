# shellcheck shell=bash
########################################
## ESubuntu                           ##
##                                    ##
## Text-processsing Functions Library ##
##                                    ##
## Bash functions for texts & strings ##
########################################

# Join arguments by char
#
# @param    $1  Joining character
# @param    $*  Items to join
#
# @return   echo
#################################
implode() {
    local IFS="${1:?'Missing field separator'}"
    shift
    echo "${*}"
}
