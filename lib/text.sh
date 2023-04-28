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
implode() {
    local IFS="${1:?"Field separator missing"}"
    shift
    echo "${*}"
}

## Read config file
##
## @param    $1  Config File
## @param    $2  Section (read only this section)
#################################################
read-file-cfg() {
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

## URL-encode string
##
## @param   $1  String to encode
################################
urlencode() {
    local string="${1:?"String missing"}"
    local encoded=
    local pos char enc_char

    # Encode each individual chars sequentially
    for (( pos=0 ; pos<${#string} ; pos++ )); do
        char="${string:${pos}:1}"
        case "${char}" in
            [-_.~a-zA-Z0-9]) enc_char="${char}" ;;
            *) printf -v enc_char "%%%02x" "'${char}" ;;
        esac
        encoded+="${enc_char}"
    done

    printf "\n%s\n" "${encoded}"
}

## Decode URL-encoded string
##
## @param   $1  String to decode
################################
urldecode() {
    local encoded="${1:?"URL-encoded string missing"}"

    # Change + to space
    encoded="${encoded//+/ }"
    # Change % to \x
    encoded="${encoded//%/\\x}"
    # Print escaped chars e.g. \x3A => :
    printf "\n'%b'\n" "${encoded}"
}

## Total lines of files in a dir
##
## @param   $1  Dir to count
## @param   $@  Extra args to 'find'
####################################
lines-dir() {
    local dir="${1:?"Directory missing"}"
    shift

    # shellcheck disable=SC2312
    find "${dir}" "${@}" -type f -print0 | xargs -0 cat | wc -l
}
