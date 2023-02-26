# Error handling

Functions for handling errors.

---

## Error codes

The following variables holds error codes that are exported so they can be used in other scripts as environment vars to indicate error causes.

```
_E_ABORT           Program aborted
_E_MISSING         Missing argument
_E_NO_CHANGE       Report no change. This can be used for idempotent scripts.
```

**Usage**

```
exit "${_E_ABORT}"
```

---

## abort

Print error message ("aborted") and exit program with `_E_ABORT` exit code.
Use this in standalone scripts. If used on the commandline it exits your shell.

**Usage**

```
abort
```

---

## error-exit

Print error message and exit program. Use this in standalone scripts.
If used on the command line it exits your shell.

**Usage**

```
error-exit MESSAGE CODE

Params:
MESSAGE            Error message
CODE               Exit code, defaults to '1'
```
