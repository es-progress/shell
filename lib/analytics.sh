# shellcheck shell=bash
################################################
## Analytics Functions Library                ##
##                                            ##
## Bash functions for statistics and analysis ##
################################################

## Analyze disk-usage
##
## @param    $1  Dir to check
## @default      Current working dir
####################################
# shellcheck disable=SC2312
anal-disk-usage() {
    local dir="${1:-.}"
    local total size dir

    total=$(du --summarize --block-size=1 "${dir}" | cut -f1)

    while IFS= read -r -d '' line; do
        read -r size dir <<<"${line}"
        printf "%3d%% %8s   %s\n" "$((size * 100 / total))" "$(numfmt --to=iec "${size}")" "${dir}"
    done < <(du --null --block-size=1 -d1 "${dir}" 2>/dev/null | sort -nz)
}
