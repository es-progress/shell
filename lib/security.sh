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

# Unlock SSH key
#
# @param    $1  Path to SSH key
# @param    $2  Path to password
################################
unlock-key() {
    local key="${1?:"Path to SSH key missing"}"
    local pass_path="${2?:"Path to password missing"}"

    # Passphrase
    password=$(pass-man retrieve "${pass_path}")
    [[ "${?}" -gt 0 ]] && return 1

    # Add key to ssh-agent
    ECHO_WRAP="${password}" DISPLAY=1 SSH_ASKPASS="wrecho" ssh-add -t 6h "${key}" </dev/null
}