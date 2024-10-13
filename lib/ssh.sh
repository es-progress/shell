# shellcheck shell=bash
##############################
## SSH Functions Library    ##
##                          ##
## Helper functions for SSH ##
##############################

## Unlock SSH key
##
## @param    $1  Path to SSH key
## @param    $2  Path to password
## @param    $3  Cache time
## @default      12 hours
#################################
unlock-key() {
    local key="${1?:Path to SSH key missing}"
    local pass_path="${2?:Path to password missing}"
    local cache_time="${3:-12h}"
    local password public_key current_identities

    password=$(pass-man retrieve "${pass_path}")
    public_key=$(cat "${key}.pub")
    current_identities=$(ssh-add -L || true)

    # Add key to ssh-agent
    if ! grep -qsx "${public_key}" <<<"${current_identities}"; then
        ECHO_WRAP="${password}" DISPLAY=1 SSH_ASKPASS=wrecho ssh-add -t "${cache_time}" "${key}" </dev/null
    fi
}

## Open SSH tunnel
##
## @param    $@  Args to SSH
############################
ssh-tunnel-open() {
    # Check if already opened
    if proc-is-running "ssh ${*}"; then
        return 0
    fi

    # Open tunnel
    ssh "${@}"

    # Check if successful
    if ! proc-is-running "ssh ${*}"; then
        echo Failed to open tunnel >&2
        return 1
    fi
}

## Close SSH tunnel
##
## @param    $@  Args to SSH
############################
ssh-tunnel-close() {
    # Check if already closed
    if ! proc-is-running "ssh ${*}"; then
        return 0
    fi

    # Close tunnel
    pkill -f "ssh ${*}"

    # Check if successful
    if proc-is-running "ssh ${*}"; then
        echo Failed to close tunnel >&2
        return 1
    fi
}

## Open socks5 tunnel
##
## @param    $1  Remote host
## @param    $2  Local port
############################
socks5-tunnel-open() {
    local remote="${1?:Remote missing}"
    local port="${2?:Local port missing}"
    ssh-tunnel-open -fqN -D "${port}" "${remote}"
}

## Close socks5 tunnel
##
## @param    $1  Remote host
## @param    $2  Local port
############################
socks5-tunnel-close() {
    local remote="${1?:Remote missing}"
    local port="${2?:Local port missing}"
    ssh-tunnel-close -fqN -D "${port}" "${remote}"
}

## Create SSH key
##
## @param    $1  Name of key
## @param    $2  Comment for key
################################
ssh-create-key() {
    local key_name="${1?:Key name missing}"
    local comment="${2?:Key comment missing}"
    shift 2
    ssh-keygen \
        -t ed25519 \
        -a 96 \
        -C "${comment}" \
        -f "${key_name}.key" "${@}"
}

## Sign a user key
##
## @param    $1  Certificate validity
## @param    $2  Path to User CA key
## @param    $3  Key identity
##   usually USER@HOST - this will be logged later
## @param    $4  Principals: user for this cert is valid
## @param    $5  Certificate serial number
## @param    $6  Path to user public key - this will be signed
##############################################################
ssh-sign-user() {
    local validity="${1?:Validity interval missing}"
    local ca_key_path="${2?:Path to CA key missing}"
    local identity="${3?:Key identity missing}"
    local principals="${4?:Principals missing}"
    local serial="${5?:Serial number missing}"
    local pubkey_path="${6?:User public key path missing}"
    shift 6
    ssh-keygen \
        -V "${validity}" \
        -s "${ca_key_path}" \
        -I "${identity}" \
        -n "${principals}" \
        -z "${serial}" \
        "${@}" -- "${pubkey_path}"
}

## View a certificate
##
## @param    $1  Path to certificate
####################################
ssh-view-cert() {
    local cert="${1?:Certificate path missing}"
    shift
    ssh-keygen -L -f "${cert}" "${@}"
}
