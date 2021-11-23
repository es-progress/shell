# shellcheck shell=bash
##########################################
## ES-Ubuntu                            ##
##                                      ##
## UI Functions Library                 ##
##                                      ##
## Bash functions to interact with user ##
##########################################

################
# FORMAT CODES #
################

_TXT_NORM="\e[0m"
_TXT_BOLD="\e[1m"
_TXT_BLUE="\e[34m"
_TXT_GREEN="\e[32m"
_TXT_RED="\e[31m"
_TXT_YELLOW="\e[33m"

#############
# FUNCTIONS #
#############

# Print error message
#
# @param    $*  Message
#######################
print-error() {
    echo -e "${_TXT_RED}${_TXT_BOLD}${*}${_TXT_NORM}"
}

# Print section header
#
# @param    $*  Message
#######################
print-section() {
    local msg="${*}"
    echo
    echo -e "${_TXT_BLUE}${_TXT_BOLD}${msg}${_TXT_NORM}"
    for ((i = 0 ; i < ${#msg} ; i++)); do
        echo -ne "${_TXT_BLUE}${_TXT_BOLD}=${_TXT_NORM}"
    done
    echo
}

# Print header
#
# @param    $*  Message
#######################
print-header() {
    echo
    echo -e "${_TXT_YELLOW}${*}${_TXT_NORM}"
}

# Print status message
#
# @param    $*  Message
#######################
print-status() {
    echo -n -e "${_TXT_YELLOW}${*}${_TXT_NORM}"
}

# Print OK message
#
# @param    $*  Message
# @default      Done
#######################
print-finish() {
    echo -e "${_TXT_GREEN}${_TXT_BOLD}${*:-"Done."}${_TXT_NORM}"
}

# Script running time
#####################
print-run-time() {
    local sec min hour

    sec=${SECONDS}
    hour=$((sec / 3600))
    sec=$((sec % 3600))
    min=$((sec / 60))
    sec=$((sec % 60))

    echo "Running time:"
    printf "%d hours %02d mins %02d secs\n" ${hour} ${min} ${sec}
}

# Ask for confirmation
######################
confirm() {
    read -r -p "Are you sure? (y/n) "
    [[ ${REPLY} == 'y' || ${REPLY} == 'Y' ]] && return 0 || return 1
}

# Clear console screen
######################
cls() {
    printf "\033c"
}
