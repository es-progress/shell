# Development Tools

Tools and utilities for development.

---

## build-mkdocs

Build an `mkdocs` site (like this one :smiley:).
Generated site's permission and group changed for serving through Apache (`www-data`).

**Usage**

```
build-mkdocs CONFIG DESTINATION

Params:
CONFIG             MkDocs config file path
DESTINATION        Destination dir for generated static site
```

---

## bump-version

Function to bump (increase by one) the version-number if semantic versioning is used.
If the major or minor version is bumped then the less important parts will be nulled as in common sense.
E.g. `1.2.3` becomes `2.0.0` after bumping major version.

**Usage**

```
bump-version VERSION PART

Params:
VERSION            Current version.
                   Must be in x.y.z format where x,y and z are integers.
PART               Which part of the version to increase (major, minor, patch)
```

---

## debug-tunnel-open

Open an SSH tunnel to a remote XDebug host. This way you can debug remote PHP applications.
This can be very handy to track down nasty bugs on production servers.
Though it's generally true that never debug in production environment, in some cases - if used correctly - this can save so much time...

**Usage**

```
debug-tunnel-open REMOTE

Params:
REMOTE             Remote host
```

---

## debug-tunnel-close

Close a previously opened SSH tunnel by `debug-tunnel-open`.

**Usage**

```
debug-tunnel-close REMOTE

Params:
REMOTE             Remote host
```

---

## ppretty-php

Pretty-prints a serialized PHP object/array. Can accept serial string from stdin also so it's great to use in a pipe.

**Usage**

```
ppretty-php [SERIAL]

Params:
SERIAL             Serialized string. If not supplied read from stdin.
```
