# shellcheck shell=bash
################################
## Database Functions Library ##
##                            ##
## Bash functions for MySQL   ##
################################

## Wrapper for mysqldump
##
## @param    $*  Args to mysqldump
##################################
db-dump-wrapper() {
    sudo mysqldump \
        --skip-lock-tables \
        --no-tablespaces \
        --single-transaction \
        --dump-date \
        --default-character-set=utf8mb4 \
        --no-create-db "${@}"
}

## Dump DB
## structure and data
##
## @param    $1  DB name
## @param    $*  Extra args to mysqldump
########################################
db-dump-full-db() {
    local db="${1:?'DB name missing'}"
    shift
    db-dump-wrapper --routines "${@}" "${db}"
}

## Dump tables from a DB
## structure and data
##
## @param    $1  DB name
## @param    $*  Tables
########################
db-dump-full-tables() {
    local db="${1:?'DB name missing'}"
    shift
    db-dump-wrapper "${db}" "${@}"
}

## Dump DB
## only structure
##
## @param    $1  DB name
## @param    $*  Extra args to mysqldump
########################################
db-dump-structure-db() {
    local db="${1:?'DB name missing'}"
    shift
    db-dump-wrapper --no-data --routines "${@}" "${db}"
}

## Dump tables from a DB
## only structure
##
## @param    $1  DB name
## @param    $*  Tables
########################
db-dump-structure-tables() {
    local db="${1:?'DB name missing'}"
    shift
    db-dump-wrapper --no-data "${db}" "${@}"
}

## Dump DB
## only data
##
## @param    $1  DB name
## @param    $*  Extra args to mysqldump
########################################
db-dump-data-db() {
    local db="${1:?'DB name missing'}"
    shift
    db-dump-wrapper --no-create-info --skip-extended-insert --skip-triggers "${@}" "${db}"
}

## Dump tables from a DB
## only data
##
## @param    $1  DB name
## @param    $*  Tables
########################
db-dump-data-tables() {
    local db="${1:?'DB name missing'}"
    shift
    db-dump-wrapper --no-create-info --skip-extended-insert --skip-triggers "${db}" "${@}"
}

## List tables from a DB
##
## @param    $1  DB name
## @param    $2  Pattern
########################
db-list-tables() {
    local db="${1:?'DB name missing'}"
    local pattern="${2:?'Pattern missing'}"
    # shellcheck disable=SC2312
    db-query "${db}" "SHOW TABLES LIKE '${pattern}'" -B | sed '1d'
}

## Run single query
##
## @param    $1  DB name
## @param    $2  Query
## @param    $*  Extra args to mysql
####################################
db-query() {
    local db="${1:?'DB name missing'}"
    local query="${2:?'Query missing'}"
    shift 2
    sudo mysql -D "${db}" -e "${query}" "${@}"
}
