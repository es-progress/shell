# shellcheck shell=bash
##############################
## ES-Ubuntu                ##
##                          ##
## SSH Functions Library    ##
##                          ##
## Helper functions for SSH ##
##############################

# Open SSH tunnel
#
# @param    $1  Args to SSH
###########################
ssh-tunnel-open(){
    local args="${1?:"Arguments to SSH missing"}"

    # Check if already opened
    if proc-is-running "ssh ${args}"; then
        return 0
    fi

    # Open tunnel
    ssh ${args}

    # Check if successful
    if ! proc-is-running "ssh ${args}"; then
        echo "Failed to open tunnel"
        return 1
    fi
}

# Close SSH tunnel
#
# @param    $1  Args to SSH
###########################
ssh-tunnel-close(){
    local args="${1?:"Arguments to SSH missing"}"

    # Check if already closed
    if ! proc-is-running "ssh ${args}"; then
        return 0
    fi

    # Close tunnel
    pkill -f "ssh ${args}"

    # Check if successful
    if proc-is-running "ssh ${args}"; then
        echo "Failed to close tunnel"
        return 1
    fi
}

# Open socks5 tunnel
#
# @param    $1  Remote host
# @param    $2  Local port
###########################
socks5-tunnel-open(){
    local remote="${1?:"Remote missing"}"
    local port="${2?:"Local port missing"}"
    ssh-tunnel-open "-fqN -D ${port} ${remote}"
}

# Close socks5 tunnel
#
# @param    $1  Remote host
# @param    $2  Local port
###########################
socks5-tunnel-close(){
    local remote="${1?:"Remote missing"}"
    local port="${2?:"Local port missing"}"
    ssh-tunnel-close "-fqN -D ${port} ${remote}"
}

# Create SSH key
#
# @param    $1  Name of key
# @param    $2  Comment for key
###############################
ssh-create-key(){
    local key_name="${1?:"Key name missing"}"
    local comment="${2?:"Key comment missing"}"

    ssh-keygen -t ed25519 -a 96 -C "${comment}" -f "${key_name}.key"
}

# Sign a user key
#
# @param    $1  Certificate validity
# @param    $2  Path to User CA key
# @param    $3  Key identity
#   usually USER@HOST - this will be logged later
# @param    $4  Principals: user for this cert is valid
# @param    $5  Certificate serial number
# @param    $6  Path to user public key - this will be signed
#############################################################
ssh-sign-user(){
    local validity="${1?:"Validity interval missing"}"
    local ca_key_path="${2?:"Path to CA key missing"}"
    local identity="${3?:"Key identity missing"}"
    local principals="${4?:"Principals missing"}"
    local serial="${5?:"Serial number missing"}"
    local pubkey_path="${6?:"User public key path missing"}"

    ssh-keygen \
        -V "${validity}" \
        -s "${ca_key_path}" \
        -I "${identity}" \
        -n "${principals}" \
        -z "${serial}" \
        -- "${pubkey_path}"
}

# View a certificate
#
# @param    $1  Path to certificate
###################################
ssh-view-cert(){
    local cert="${1?:"Certificate path missing"}"
    ssh-keygen -L -f "${cert}"
}
