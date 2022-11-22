# shellcheck shell=bash
##############################
## Network Library          ##
##                          ##
## Utilities for networking ##
##############################

## Retrieve Email related DNS records
##
## @param    $1  Domain
## @param    $2  DKIM selector
#####################################
dns-mail() {
    local domain="${1?:"Domain missing"}"
    local selector="${2?:"DKIM selector missing"}"

    print-header SPF
    dig TXT "${domain}"
    print-header DMARC
    dig TXT "_dmarc.${domain}"
    print-header DKIM
    dig TXT "${selector}._domainkey.${domain}"
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
