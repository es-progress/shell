# shellcheck shell=bash
##########################
## Audio/Video Library  ##
##                      ##
## Wrapper for 'ffmpeg' ##
##########################

## Add standard params to 'ffmpeg'
##
## @private
## @param    $@  Params to pass
##################################
_fffmpeg() {
    ffmpeg -hide_banner "${@}"
}

## Cut a video file
##
## @param    $1  Input file
## @param    $2  Output file
## @param    $@  Positions
##               -ss START_TIME [-t DURATION]
#############################################
fffmpeg-cut() {
    local input_file="${1:?Input file missing}"
    local output_file="${2:?Output file missing}"
    shift 2
    _fffmpeg -i "${input_file}" "${@}" -preset veryfast "${output_file}"
}

## Join multiple video files
##
## @param    $1  Output file
## @param    $@  Input files
############################
fffmpeg-join() {
    local output_file="${1:?Output file missing}"
    local temp_file input_file
    temp_file=$(mktemp)
    shift

    for input_file in "${@}"; do
        input_file=$(realpath "${input_file}")
        echo "file '${input_file}'" >> "${temp_file}"
    done

    _fffmpeg -f concat -safe 0 -i "${temp_file}" -c copy "${output_file}"
}
