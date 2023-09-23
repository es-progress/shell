# Process

Functions for managing processes.

---

## check-not-root

Check if script is not running as root. If running as root print error and return with non-zero exit code.

**Usage**

```
check-not-root
```

---

## check-root

Determine if script is running as root. If not running as root print error and return with non-zero exit code.

**Usage**

```
check-root
```

---

## command-exists

Verify if command is available on the system. Return non-zero exit code if the command is not available.

**Usage**

```
command-exists COMMAND

Params:
COMMAND            Command to check
```

---

## foreach-subdir

Run command in each sub directory of current working dir.
Commands are executed in a subshell so it will continue on errors and has no effects on current shell.

**Usage**

```
foreach-subdir COMMAND

Params:
COMMAND            Command to run
```

---

## foreach-subdir-pipe

Run command in each sub directory of current working dir and pipe results to another command.
Commands are executed in a nested shell so it will continue on errors and has no effects on current shell.

**Usage**

```
foreach-subdir-pipe COMMAND PIPE

Params:
COMMAND            Command to run
PIPE               Command to pipe to
```

---

## monitor-proc-memory

Monitor memory usage - actually resident set size (RSS), the non-swapped physical memory that a process has used.
Memory usage is printed on every seconds. Peak RSS is saved and printed on screen also.

**Usage**

```
monitor-proc-memory COMMAND

Params:
COMMAND            Command optionally with arguments
```

---

## proc-is-running

Check if process is running. Return non-zero exit code if not running.

**Usage**

```
proc-is-running COMMAND

Params:
COMMAND            Command to check
```
