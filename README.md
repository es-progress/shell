# Bash Shell scripts & functions

[![CI](https://github.com/es-progress/shell/actions/workflows/shell.yml/badge.svg)](https://github.com/es-progress/shell/actions/workflows/shell.yml)

## Overview

This is a collection of utility scripts and helper functions.

You can find scripts in `bin/` directory and function libraries in `lib/` dir.
For details see the [documentation](https://shell.es-progress.hu/).

## Usage

Most scripts use functions from the libraries, so they need to get sourced inside scripts to be available.
For this purpose there's a loader: `lib/_loader.sh`. All it does is including every library file from `lib/` dir.

So if you need the libraries, simply include (source) the loader, and it does the job.
In supplied scripts loader is referenced by an environment variable (`ES_SHELL_LOADER`), this means you need to set path to `lib/_loader.sh` in `ES_SHELL_LOADER`.
It's recommended to use this env var in your scripts also:

```
# Use absolute path
. /path/to/shell/lib/_loader.sh
# Or use the envvar (recommended for maintainabilty & portability)
. "${ES_SHELL_LOADER}"
```

**Tip**: source loader in your `.bashrc`, so functions will be available for you on the command line!

## NOTE

This project is licensed under the MIT license, so feel free to copy or use for inspirations! :heart:

Also PRs are always welcomed!
