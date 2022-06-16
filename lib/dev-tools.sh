# shellcheck shell=bash
##############################
## Development Tools        ##
##                          ##
## Helper functions for dev ##
##############################

## Retrieve Email related DNS records
##
## @param    $1  Domain
## @param    $2  DKIM selector
#####################################
debug-dns-mail() {
    local domain="${1?:"Domain missing"}"
    local selector="${2?:"DKIM selector missing"}"

    print-header SPF
    dig TXT "${domain}"
    print-header DMARC
    dig TXT "_dmarc.${domain}"
    print-header DKIM
    dig TXT "${selector}._domainkey.${domain}"
}

## Open SSH tunnel to remote XDebug
##
## @param    $1  Remote host
###################################
debug-tunnel-open() {
    local remote="${1?:"Remote missing"}"
    ssh-tunnel-open -fqN -R 9003:localhost:9003 "${remote}"
}

## Close SSH tunnel to remote XDebug
##
## @param    $1  Remote host
####################################
debug-tunnel-close() {
    local remote="${1?:"Remote missing"}"
    ssh-tunnel-close -fqN -R 9003:localhost:9003 "${remote}"
}

## Build mkdocs site
##
## @param    $1  mkdocs config file path
## @param    $2  Build destination
########################################
build-mkdocs() {
    local config_file="${1?:"mkdocs config file missing"}"
    local destination="${2?:"Build destination missing"}"

    mkdocs build -f "${config_file}" -d "${destination}"

    chmod -R g-w,o-rwx "${destination}"
    chgrp -R www-data "${destination}"
}

## Query ipstack for GeoIP data
##
## @param    $1  IP address
###############################
iplocation() {
    : "${1?:"IP address missing"}"
    local params result
    params="access_key=${IPSTACK_TOKEN}&fields=city,region_name,country_name,continent_name,hostname,ip&hostname=1"

    for arg in "${@}"; do
        if ! result=$(curl --no-progress-meter -w"\n" "http://api.ipstack.com/${arg}?${params}"); then
            return 1
        fi
        jq '.' <<<"${result}"
    done
}

## Pretty print serialized PHP object
##
## @param   $1  Serial string
#####################################
ppretty-php() {
    local serial="${1?:"Serialized data missing"}"
    php <<EOF
<?php
echo "\n";
var_export(unserialize('${serial}'));
echo "\n";
?>
EOF
}
