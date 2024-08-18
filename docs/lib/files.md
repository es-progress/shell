# Files

Functions for managing files and querying the filesystem.

---

## dir-file

Get the directory of a file.

**Usage**

```
dir-file FILE

Params:
FILE               File to check
```

---

## dir-parents

Retrieve all parent directories of a dir. By default, return parents as a space-separated string.
The separator character can be specified if directories containing whitespace are a concern.

**Usage**

```
dir-parents DIRECTORY SEPARATOR

Params:
DIRECTORY          Directory to check. Defaults to current dir.
SEPARATOR          Separator character. Defaults to space.
```

---

## dir-script

Get directory of currently running script.

**Usage**

```
dir-script
```

---

## give

Recursively set group ownership and remove all world (public) permissions on directories.

**Usage**

```
give GROUP DIRECTORY...

Params:
GROUP             Group name
DIRECTORY         Directory to set permissions
```
