# shellcheck shell=bash
##############################
## Development Tools        ##
##                          ##
## Helper functions for dev ##
##############################

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

## Pretty print serialized PHP object
##
## @param   $1  Serial string
#####################################
ppretty-php() {
    local serial="${1:-}"
    [[ -z "${serial}" ]] && read -r serial

    php <<EOF
<?php
echo "\n";
print_r(unserialize('${serial}'));
echo "\n";
?>
EOF
}

## Bump version (for semantic versioning)
##
## @param   $1  Current version
## @param   $2  Which part to bump (major, minor, patch)
########################################################
bump-version() {
    local version="${1?:"Version missing"}"
    local part="${2?:"Version part missing"}"
    local major minor patch

    IFS=$'.' read -r major minor patch <<< "${version}"
    if [[ ! "${major}" =~ ^[0-9]+$ ]]; then
        print-error "Invalid version"
        return 1
    fi
    if [[ ! "${minor}" =~ ^[0-9]+$ ]]; then
        print-error "Invalid version"
        return 1
    fi
    if [[ ! "${patch}" =~ ^[0-9]+$ ]]; then
        print-error "Invalid version"
        return 1
    fi

    case "${part}" in
        major)
            major=$((major + 1))
            minor=0
            patch=0
            ;;
        minor)
            minor=$((minor + 1))
            patch=0
            ;;
        patch)
            patch=$((patch + 1))
            ;;
        *)
            print-error "Invalid part"
            return 1
            ;;
    esac

    echo "${major}.${minor}.${patch}"
}
