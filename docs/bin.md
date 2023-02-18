# Bin

Various shell scrits that can be used as "binaries".

---

## backup

A wrapper for `rsync`. Backups source directory to a different filesystem (drive) as backing up on the same drive defies the goal of backup.
In archive mode backups are compressed to save disk space.
This compression is done by `pigz` which creates standard `gzip` files but spreads the work over multiple processors and cores when compressing so it can utilize modern hardware.

Modes:

-   Archive
    1. Copy files to destination dir (`rsync`)
    1. Create single archive file from backed up files (`tar` & `pigz`)
    1. Rotate (delete) old archives (`find`)
-   Quick: only copying files to destination.
-   Snapshot: backup only changed files from last backup.
    Not changed files get hard-linked from previous run so you can access normally & restore easily but using way less disk space.
    This is a quick and efficient way to create many backups.

**Usage**

```
backup REQUIRED_OPTIONS... [OPTIONS...]

OPTIONS

REQUIRED
-s, --source [DIR]         source DIRECTORY to backup
-d, --destination [DIR]    destination DIRECTORY to put backup on
                           target filesystem (relative to mounting point)
-f, --filesystem [FS]      target FILESYSTEM to backup to (eg. /dev/sda3)
-m, --mount [DIR]          mounting point for given filesystem

OPTIONAL
-a, --archive [DIR]        put archives in DIR, defaults to 'archive'
    --expire [NUM]         deletes archives older than NUM days (NUM*24 hours)
    --format [FORMAT]      appends current date to archive filename
                           supported FORMATS:
                               24H (HH:MM:SS eg. 17:26:14)
                               YMD (YYYY-mm-dd eg. 2020-02-19)       <--default
                               FULL (YYYY-mm-dd_HH:MM:SS)
    --mode [MODE]          select MODE:
                               ARCHIVE:  backup and create archives  <--default
                               SNAPSHOT: snapshot backup
                               QUICK:    backup only
    --exclude [PATTERN]    exclude files matching PATTERN
    --prefix [STRING]      optional prefix on archive files
    --debug                print commands as executed
-h, --help                 display this help
-v, --version              print version info
```

---

## benchmark

A wrapper and runner for `sysbench`.
You can design multiple test runs with different test parameters, so you can benchmark the system for:

-   CPU
-   Memory
-   Disks
-   Download speed

in a single script.

Default test parameters are provided but you can override them in a params file.
This file is sourced so you can change parameters by setting new values to config variables found in "CONFIG" section.
For parameter formats check said section in script.

An example params file:

```
# You can have comments
# Let's have bit longer tests
test_run_time_quick=20
# Run only one deep memory benchmark
runs_memory_deep=()
runs_memory_deep+=("1;512;30G;rnd")
```

!!! info
    This script is completely standalone, no bootstrapping is required, just copy to target system and start benchmarking! :metal:

**Usage**

```
Usage: benchmark [OPTIONS]...

OPTIONS

-c, --cpu
-m, --memory
-d, --disk
    --download
                       Run appropriate test. If no test specified, all will run.
                       Ignored if '-s' given.
-s, --system           Run only a system check
-r, --report           Save test report to file
    --report-prefix    Report file prefix, implies '-r'
-q, --quick            Do a quick benchmark. Ignored if '-s' given.
    --deep             Deep benchmarking. Ignored if '-s' given.
-p, --params           Config file to override test parameters

-h, --help             Display this help
-v, --version          Print version
```
