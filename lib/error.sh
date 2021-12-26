# shellcheck shell=bash
#######################################
## ES-Ubuntu                         ##
##                                   ##
## Error Functions Library           ##
##                                   ##
## Bash functions for error handling ##
#######################################

###############
# ERROR CODES #
###############

# Aborted
_E_ABORT=10

#############
# FUNCTIONS #
#############

## Print error message and exit
## program with error code
##
## @param    $1  Error Message
## @default      "fatal error"
## @param    $2  Error code
## @default      1
###############################
error_exit(){
    print-error "${1:-"fatal error"}"
    exit "${2:-1}"
}

## Abort program
################
abort(){
    print-error "Aborted."
    exit ${_E_ABORT}
}
