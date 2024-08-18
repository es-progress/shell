# Development Tools

This section provides a range of utilities and functions to assist in the development process.

---

## build-mkdocs

Build an MkDocs site (like this one :smiley:).
The generated site's permissions and group are changed for serving through Apache (`www-data`).

**Usage**

```
build-mkdocs CONFIG DESTINATION [EXTRA]...

Params:
CONFIG             MkDocs config file path
DESTINATION        Destination dir for generated static site
EXTRA              Optional extra params to 'mkdocs build'
```

---

## bump-version

Function to increment (increase by one) the version number if semantic versioning is used.
If the major or minor version is bumped, the less important parts will be reset.
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

Open an SSH tunnel to a remote XDebug host, allowing you to debug remote PHP applications.
This can be very handy to track down nasty bugs on production servers.
Though it's generally advised to never debug in production environment, in some cases - if used correctly - this can save so much time...

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

## ppretty-json

Pretty prints JSON string. Can accept JSON from stdin also so it's great to use in a pipe.

**Usage**

```
ppretty-json [JSON]

Params:
JSON               JSON string. If not supplied read from stdin.
```

---

## ppretty-php

Pretty prints a serialized PHP object/array. Can accept serial string from stdin also so it's great to use in a pipe.

**Usage**

```
ppretty-php [SERIAL]

Params:
SERIAL             Serialized string. If not supplied read from stdin.
```
