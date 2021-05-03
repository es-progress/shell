# shellcheck shell=bash
########################################
## ES-Ubuntu                          ##
##                                    ##
## Text-processsing Functions Library ##
##                                    ##
## Bash functions for texts & strings ##
########################################

# Join arguments by char
#
# @param    $1  Joining character
# @param    $*  Items to join
#################################
implode() {
    local IFS="${1:?"Field separator missing"}"
    shift
    echo "${*}"
}
