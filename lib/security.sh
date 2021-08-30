# shellcheck shell=bash
#######################################
## ES-Ubuntu                         ##
##                                   ##
## Security Functions Library        ##
##                                   ##
## Bash functions regarding security ##
#######################################

# Check if run as root
######################
check-root() {
    if [[ $(id -u) -ne 0 ]]; then
        print-error "Run as root!"
        return 1
    fi
    return 0
}

# Check if not run as root
##########################
check-not-root() {
    if [[ $(id -u) -eq 0 ]]; then
        print-error "Don't run as root!"
        return 1
    fi
    return 0
}
