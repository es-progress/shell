# ffmpeg

Wrapper for the `ffmpeg` tool.

---

## fffmpeg-cut

Cut a shot from a video file. The wrapper passes any ffmpeg timing/options you provide.

**Usage**

```
fffmpeg-cut INPUT_FILE OUTPUT_FILE TIMING_POSITIONS

Params:
INPUT_FILE         Path to input video file
OUTPUT_FILE        Path to output video file
TIMING_POSITIONS   Time positions to specify the start and end of cutted segment
                   Example to extract 10s from 1min: -ss 60 -t 10
                                                 or: -ss 00:01:00 -t 00:00:10
```

---

## fffmpeg-join

Join multiple video files using `ffmpeg` concat demuxer.

**Usage**

```
fffmpeg-join OUTPUT_FILE INPUT_FILE...

Params:
OUTPUT_FILE        Path to resulting joined file
INPUT_FILE         One or more input files to concatenate
```
