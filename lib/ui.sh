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

TXT_NORM=$(tput sgr0)
TXT_BOLD=$(tput bold)
TXT_RED=$(tput setaf 1)
TXT_YELLOW=$(tput setaf 3)
TXT_GREEN=$(tput setaf 2)
TXT_BLUE=$(tput setaf 4)

#############
# FUNCTIONS #
#############

# Print error message
#
# @param    $*  Message
#######################
print-error() {
    echo -e "${TXT_RED}${TXT_BOLD}${*}${TXT_NORM}"
}

# Print section header
#
# @param    $*  Message
#######################
print-section() {
    local msg="${*}"
    echo
    echo -e "${TXT_BLUE}${TXT_BOLD}${msg}${TXT_NORM}"
    for ((i = 0 ; i < ${#msg} ; i++)); do
        echo -ne "${TXT_BLUE}${TXT_BOLD}=${TXT_NORM}"
    done
    echo
}

# Print header
#
# @param    $*  Message
#######################
print-header() {
    echo
    echo -e "${TXT_YELLOW}${*}${TXT_NORM}"
}

# Print status message
#
# @param    $*  Message
#######################
print-status() {
    echo -n -e "${TXT_YELLOW}${*}${TXT_NORM}"
}

# Print OK message
#
# @param    $*  Message
# @default      Done
#######################
print-finish() {
    echo -e "${TXT_GREEN}${TXT_BOLD}${*:-"Done."}${TXT_NORM}"
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
