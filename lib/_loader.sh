# shellcheck shell=bash
# shellcheck disable=SC1091
########################
## Loader             ##
##                    ##
## Sourcing libraries ##
########################

path_self=$(realpath "${BASH_SOURCE[0]}")
base_dir=$(cd "$(dirname "${path_self}")" >/dev/null 2>&1 && pwd)

. "${base_dir}/analytics.sh"
. "${base_dir}/certificate.sh"
. "${base_dir}/db.sh"
. "${base_dir}/dev.sh"
. "${base_dir}/error.sh"
. "${base_dir}/files.sh"
. "${base_dir}/git.sh"
. "${base_dir}/github.sh"
. "${base_dir}/network.sh"
. "${base_dir}/process.sh"
. "${base_dir}/ssh.sh"
. "${base_dir}/text.sh"
. "${base_dir}/ui.sh"

if [[ -r "${ES_SHELL_LOADER_LOCAL:-}" ]]; then
    # shellcheck disable=SC1090
    . "${ES_SHELL_LOADER_LOCAL}"
fi
