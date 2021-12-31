# shellcheck shell=bash
########################################
## Text-processsing Functions Library ##
##                                    ##
## Bash functions for texts & strings ##
########################################

## Join arguments by char
##
## @param    $1  Joining character
## @param    $*  Items to join
##################################
implode(){
    local IFS="${1:?"Field separator missing"}"
    shift
    echo "${*}"
}

## Read JSON file
##
## @param    $1  JSON File
##########################
read-file-json(){
    local file="${1:?"File missing"}"
    shift
    jq -rcM "${@}" '.[]' "${file}"
}

## Read config file
##
## @param    $1  Config File
## @param    $2  Section (read only this section)
#################################################
read-file-cfg(){
    local file="${1:?"File missing"}"
    local section="${2:-}"
    local contents

    # Remove blank lines, comments
    contents=$(sed -r -e '/^\s*$/ d' -e '/\s*#/ d' "${file}")

    # If a section is supplied return just that
    [[ -n "${section}" ]] && contents=$(sed -nr -e "/^\s*\[${section}\]/ , /^\s*\[.*\]/ p" <<<"${contents}")

    # Delete section headers
    sed -r -e '/^\s*\[/ d' <<<"${contents}"
}
