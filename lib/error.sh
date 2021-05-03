# shellcheck shell=bash
#######################################
## ESubuntu                          ##
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

# Print error message and exit program with error code
#
# @param    $1  Error Message
# @param    $2  Error code
# @default      1
######################################################
error_exit(){
    print-error "${1:-}"
    exit "${2:-1}"
}

# Aborts program
################
abort(){
    print-error "Aborted."
    exit ${_E_ABORT}
}
