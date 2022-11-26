# shellcheck shell=bash
##############################
## Network Library          ##
##                          ##
## Utilities for networking ##
##############################

## Retrieve email related DNS records
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
## @param    $*  IP address
###############################
iplocation() {
    local params result
    params="access_key=${IPSTACK_TOKEN}&fields=city,region_name,country_name,continent_name,hostname,ip&hostname=1"

    for arg in "${@}"; do
        if ! result=$(curl --no-progress-meter -w"\n" "http://api.ipstack.com/${arg}?${params}"); then
            return 1
        fi
        jq '.' <<<"${result}"
    done
}

## Return my external IPv4 address
##################################
whatsmyip4() {
    dig -r4 +short @ns1.google.com. o-o.myaddr.l.google.com. TXT
}

## Return my external IPv6 address
##################################
whatsmyip6() {
    dig -r6 +short @ns1.google.com. o-o.myaddr.l.google.com. TXT
}
