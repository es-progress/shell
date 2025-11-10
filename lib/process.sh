# shellcheck shell=bash
###################################
## Processes & running           ##
##                               ##
## Functions regarding processes ##
###################################

## Check if run as root
#######################
check-root() {
    local uid
    uid=$(id -u)
    if [[ "${uid}" -ne 0 ]]; then
        print-error Run as root!
        return 1
    fi
    return 0
}

## Check if not run as root
###########################
check-not-root() {
    local uid
    uid=$(id -u)
    if [[ "${uid}" -eq 0 ]]; then
        print-error "Don't run as root!"
        return 1
    fi
    return 0
}

## Run command in each sub directory
##
## @param    $*  Command to run
####################################
foreach-subdir() {
    # shellcheck disable=SC2312
    while IFS= read -r -d '' dir; do
        print-section "${dir}"
        (
            cd "${dir}" || return 1
            "${@}"
        )
    done < <(find . -mindepth 1 -maxdepth 1 -type d -print0 | sort -z)
}

## Run command in each sub directory
##
## @param    $1  Command to run
## @param    $2  Command to pipe to
####################################
foreach-subdir-pipe() {
    local command="${1:?Command missing}"
    local pipe="${2:?Pipe command missing}"
    # shellcheck disable=SC2312
    while IFS= read -r -d '' dir; do
        print-section "${dir}"
        (
            cd "${dir}" || return 1
            # shellcheck disable=SC2312
            ${command} | ${pipe}
        )
    done < <(find . -mindepth 1 -maxdepth 1 -type d -print0 | sort -z)
}

## Check if a command is running
##
## @param    $1  Command name
################################
proc-is-running() {
    local command="${1:?Command missing}"
    shift
    pgrep -f "${@}" "${command}" >/dev/null 2>&1
}

## Check if command exists
##
## @param    $@  Command
##########################
command-exists() {
    command -v "${@}" >/dev/null 2>&1
}

## Monitor memory usage of a process
##
## @param    $*  Command (with args)
####################################
monitor-proc-memory() {
    local pid date rss rss_print max max_print counter height

    max=0
    counter=1
    height=$(tput lines)
    while :; do
        date=$(date +"%F %T")

        # Print header
        if [[ "${counter}" -eq 1 ]]; then
            printf "%20s %20s %20s\n" Date "RSS (KiB)" "MAX RSS (KiB)"
            for ((i = 0 ; i < 62 ; i++)); do
                echo -n "-"
            done
            echo
        fi

        pid=$(pgrep -f "${*}")
        rc=$?
        case "${rc}" in
            0)
                if rss=$(ps -p"${pid}" -orss=); then
                    [[ "${rss}" -gt "${max}" ]] && max="${rss}"
                    rss_print=$(numfmt --grouping <<<"${rss}")
                    max_print=$(numfmt --grouping <<<"${max}")
                    printf "%20s %20s %20s\n" "${date}" "${rss_print}" "${max_print}"
                else
                    print-error "ps error (probably more than 1 process matched command)"
                    return "${rc}"
                fi
                ;;
            1)
                max=0
                printf "%20s ${TXT_RED}%41s${TXT_NORM}\n" "${date}" "Process not running"
                ;;
            *)
                print-error pgrep error
                return "${rc}"
                ;;
        esac

        counter=$(( counter + 1))
        [[ "${counter}" -eq "${height}" ]] && counter=1
        sleep 1
    done
}
