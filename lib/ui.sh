# shellcheck shell=bash
##########################################
## UI Functions Library                 ##
##                                      ##
## Bash functions to interact with user ##
##########################################

##################
## FORMAT CODES ##
##################

export TXT_NORM="\e[0m"
export TXT_BOLD="\e[1m"
export TXT_RED="\e[31m"
export TXT_GREEN="\e[32m"
export TXT_YELLOW="\e[33m"
export TXT_BLUE="\e[34m"
export TXT_PURPLE="\e[35m"
export BACK_BLUE="\e[44m"

###############
## FUNCTIONS ##
###############

## Print error message
##
## @param    $*  Message
########################
print-error() {
    [[ -n "${ES_PRINT_HUSH:-}" ]] && return 0
    echo -e "${TXT_RED}${TXT_BOLD}${*}${TXT_NORM}" >&2
}

## Print section header
##
## @param    $*  Header
#######################
print-section() {
    local header="${*}"
    [[ -n "${ES_PRINT_HUSH:-}" ]] && return 0
    echo
    echo -e "${BACK_BLUE}${header}${TXT_NORM}"
    echo -ne "${BACK_BLUE}"
    for ((i = 0 ; i < ${#header} ; i++)); do
        echo -n "~"
    done
    echo -e "${TXT_NORM}"
}

## Print header
##
## @param    $*  Header
#######################
print-header() {
    [[ -n "${ES_PRINT_HUSH:-}" ]] && return 0
    echo
    echo -e "${TXT_YELLOW}${*}${TXT_NORM}"
}

## Print status message
##
## @param    $*  Message
########################
print-status() {
    [[ -n "${ES_PRINT_HUSH:-}" ]] && return 0
    echo -ne "${TXT_YELLOW}${*}${TXT_NORM}"
}

## Print OK message
##
## @param    $*  Message
## @default      Done
########################
print-finish() {
    [[ -n "${ES_PRINT_HUSH:-}" ]] && return 0
    echo -e "${TXT_GREEN}${TXT_BOLD}${*:-Done.}${TXT_NORM}"
}

## Script running time
######################
print-run-time() {
    local sec min hour
    [[ -n "${ES_PRINT_HUSH:-}" ]] && return 0

    sec=${SECONDS}
    hour=$((sec / 3600))
    sec=$((sec % 3600))
    min=$((sec / 60))
    sec=$((sec % 60))

    echo "Running time:"
    printf "%d hour(s) %02d min(s) %02d second(s)\n" "${hour}" "${min}" "${sec}"
}

## Ask for confirmation
##
## @param    $*  Prompt
## @default      Are you sure? (y/n)
####################################
confirm() {
    read -r -p "${*:-Are you sure? (y/n) }"
    [[ ${REPLY} == "y" || ${REPLY} == "Y" ]] && return 0 || return 1
}

## Clear console screen
#######################
cls() {
    printf "\033c"
}
