# shellcheck shell=bash
####################################
## ESubuntu                       ##
##                                ##
## Path Functions Library         ##
##                                ##
## Bash functions involving paths ##
####################################

# Get directory of a file
#
# @param    $1  File
#########################
dir-file(){
    local file="${1:?'File missing'}"

    if [[ ! -f "${file}" ]]; then
        print-error "Not a file"
        return 1
    fi

    # cd in subshell
    base_dir="$(builtin cd "$(dirname "${file}")" >/dev/null 2>&1 && pwd)"
    echo "${base_dir}"
}

# Get directory of running script
#################################
dir-script(){
    dir-file "${BASH_SOURCE[0]}"
}

# Get all parent directory of a dir
#
# @param    $1  Directory
###################################
dir-parents() {
    local dir="${1:?'Directory missing'}"
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

    echo "${parents[*]}"
}
