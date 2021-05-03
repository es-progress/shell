# shellcheck shell=bash
##############################
## ESubuntu                 ##
##                          ##
## Development Tools        ##
##                          ##
## Helper functions for dev ##
##############################

# Retrieve Email related DNS records
#
# @param    $1  Domain
# @param    $2  DKIM selector
####################################
debug-dns-mail(){
    local domain="${1?:"Domain missing"}"
    local selector="${2?:"DKIM selector missing"}"

    print-header "SPF"
    dig TXT "${domain}"
    print-header "DMARC"
    dig TXT "_dmarc.${domain}"
    print-header "DKIM"
    dig TXT "${selector}._domainkey.${domain}"
}

# Open SSH tunnel to remote XDebug
#
# @param    $1  Remote host
##################################
debug-tunnel-open(){
    local remote="${1?:"Remote missing"}"
    ssh-tunnel-open "-fqN -R 9003:localhost:9003 ${remote}"
}

# Close SSH tunnel to remote XDebug
#
# @param    $1  Remote host
###################################
debug-tunnel-close(){
    local remote="${1?:"Remote missing"}"
    ssh-tunnel-close "-fqN -R 9003:localhost:9003 ${remote}"
}

# Build mkdocs site
#
# @param    $1  mkdocs config file path
# @param    $2  Build destination
#######################################
build-mkdocs(){
    local config_file="${1?:"mkdocs config file missing"}"
    local destination="${2?:"Build destination missing"}"

    # Build doc
    mkdocs build -f "${config_file}" -d "${destination}"

    # Set permissions
    chmod -R g-w,o-rwx "${destination}"
    chgrp -R www-data "${destination}"
}
