#!/usr/bin/env bash
###############################
## ES-Ubuntu                 ##
##                           ##
## SFTP Functions Library    ##
##                           ##
## Helper functions for SFTP ##
###############################

run_cmd() {
    local result

    result=$(sftp -b - gaia <<<"${1}")

    sed '1d' <<<$result
}

get_files() {
    local files

    result=$(run_cmd "ls -l ${1}")

    files=$(sed '/^d/ d' <<<$result)

    sizes=$(awk '{print $5}' <<<$files)
}
