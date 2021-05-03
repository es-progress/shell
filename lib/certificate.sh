# shellcheck shell=bash
###################################
## ES-Ubuntu                     ##
##                               ##
## Certificate Functions Library ##
##                               ##
## Managing certificates & keys  ##
###################################

# View certificate
#
# @param    $1  Certificate file
################################
cert-view(){
    local cert="${1?:"Certificate missing"}"
    ssh-keygen -L -f "${cert}"
}
