# shellcheck shell=bash
###################################
## Path Functions Library        ##
##                               ##
## Bash functions                ##
## Involving paths & permissions ##
###################################

## Get directory of a file
##
## @param    $1  File
##########################
dir-file() {
    local file="${1:?"File missing"}"

    if [[ ! -f "${file}" ]]; then
        print-error "Not a file"
        return 1
    fi

    base_dir="$(builtin cd "$(dirname "${file}")" >/dev/null 2>&1 && pwd)"
    echo "${base_dir}"
}

## Get directory of running script
##################################
dir-script() {
    dir-file "${BASH_SOURCE[0]}"
}

## Get all parent directory of a dir
##
## @param    $1  Directory
####################################
dir-parents() {
    local dir="${1:?"Directory missing"}"
    local parents=()

    # Convert to absolute path
    dir="$(realpath "${dir}")"

    if [[ ! -d "${dir}" ]]; then
        print-error "Not a directory"
        return 1
    fi

    while :; do
        dir=${dir%/*}
        parents+=("${dir}")
        [[ -z "${dir}" ]] && break
    done

    echo "${parents[@]}"
}

## Recursively set group on directory to user
## And remove world permissions
##
## @param   $1  Group
## @param   $2  Directory
#############################################
give() {
    local user="${1:?"User missing"}"
    local dir="${2:?"Directory missing"}"
    shift 2
    sudo chgrp -R "${user}" "${dir}" "${@}"
    sudo chmod -R o-rwx "${dir}" "${@}"
}
