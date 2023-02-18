# Bin

Various shell scripts that can be used as "binaries".

---

## backup

A wrapper for `rsync`.
Backups source directory to a different filesystem (drive) as backing up on the same drive sort of defies the goal of backup.
In archive mode backups are compressed to save disk space.
This compression is done by `pigz` which creates standard `gzip` files but spreads the work over multiple processors and cores when compressing so it can utilize modern hardware.

Modes:

-   Archive
    1. Copy files to destination dir (`rsync`)
    1. Create single archive file from backed up files (`tar` & `pigz`)
    1. Rotate (delete) old archives (`find`)
-   Quick: only copy files to destination.
-   Snapshot: backup only changed files from last backup.
    Not changed files get hard-linked from previous run so you can access them normally & restore easily but using way less disk space.
    This is a quick and efficient way to create many backups.

**Usage**

```
backup REQUIRED_OPTIONS... [OPTIONS]...

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
This file is sourced during execution so you can change parameters by setting new values to config variables found in "CONFIG" section.
For parameter formats check said section in the script (Bash syntax).

An example params file:

```
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

---

## clean

Clean-up temporary and other not needed files to free up disk space:

-   Remove unused `apt` packages
-   Remove old snaps
-   Rotate system journal (keep 2 weeks of logs)
-   Delete caches

!!! info
    This script is completely standalone, no bootstrapping is required!
    Perfect to run weekly by cron.

**Usage**

```
Usage: clean
```

---

## generate-moduli

Regenerate Diffie-Hellman groups used for the "Diffie-Hellman Group Exchange" key exchange method.
This can be used for OpenSSH server (`/etc/ssh/moduli`).

!!! warning
    This is possibly a long running process!

**Usage**

```
Usage: generate-moduli [BITS] [OUTPUT]

Params:
BITS               Comma-separated list of size of prime in bits to generate.
                   Defaults to 4096,6144,7680,8192
OUTPUT             Output generated primes to this file.
                   Defaults to "DH_moduli" in current dir
```

---

## pass-man

Manages a `pass` password store which is inside a `tomb`.

Available actions:

-   open: open password store in tomb
-   close: close password store
-   generate: generate a password but not save as a pass. Useful if you just need a strong key.
-   retrieve: get password from store

**Usage**

```
Usage: pass-man ACTION [TARGET] [EXTRA]...

Params:
ACTION             Action to perform (open, close, generate, retrieve)
TARGET             Path to password in password store (mandatory for 'retrieve' action)
EXTRA              Extra arguments to 'pass'
```

---

## sign-kernel-modules

Sign kernel modules with a Machine Owner Key (MOK).
Some modules are not signed by Ubuntu so kernel won't load them.
After signing they can be loaded with `modprobe`.

For this you need a MOK key and certificate and it needs to be enrolled in EFI:

1. Generate MOK key
    ```
    openssl genpkey -algorithm rsa -out MOK_KEY
    ```
1. Create MOK certificate
    ```
    openssl req -new -x509 -key MOK_KEY -outform DER -out MOK_CERT
    ```
1. Enroll MOK certificate
    ```
    mokutil --import MOK_CERT
    ```
1. Reboot and perform enrolling

**Usage**

```
Usage: sign-kernel-modules MODULE KEY CERT

Params:
MODULE             Module to sign (e.g. vboxdrv)
KEY                MOK private key file
CERT               MOK certificate file
```

---

## sourcer

Helper script to bootstrap libraries. This script sources all library files so functions will be available to use.
Basically you need to source this file in any script where you want to use library functions:

```
# Source sourcer
. /path/to/sourcer
# Now functions are defined
check-root
error-exit "Nothing to do"
```

You can find more details about bootstrapping in the [Installation instructions](install.md).

!!! tip
    Put sourcer in your `.bashrc` and all functions are ready to use in your terminal.
    Actually some of them are meant for interactive use on the command line!

---

## test-dd-write

Test 'dd' write speed with different block sizes. This way you can optimize block size for fastest write operation.

**Usage**

```
Usage: test-dd-write
```

---

## wrecho

A wrapper for `echo`. All it does is echo the contents of an environment variable: `ECHO_WRAP`.
Useful if you need to send a string to some application, but it can receive that only from a script.

Example:

```
export ECHO_WRAP=password
export SSH_ASKPASS=/path/to/wrecho
ssh-add SSH_KEY </dev/null
```

**Usage**

```
Usage: ECHO_WRAP="some string to echo" wrecho
```
