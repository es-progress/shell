# Bash Shell scripts & functions

[![CI](https://github.com/es-progress/shell/actions/workflows/main.yml/badge.svg)](https://github.com/es-progress/shell/actions/workflows/main.yml)

## Overview
This is a collection of utility scripts and helper functions.

You can find the scripts in the `bin/` directory and the function libraries in the `lib/` dir.

For details please check the documentation.

## Usage
Most scripts use functions from the libraries, so they need to get sourced inside the scripts, to be available.
For this there is the `sourcer`. All it does is include every library file from the `lib` dir.

For it to work it uses an environment variable (`DIR_SHELL_LIB`) to get the path of the `lib` directory. If this variable is not found it
assumes the `lib` is in the same place as in this repo.

So if you need the libraries, simply include (source) the `sourcer` script, and it does the job.
```
. /path/to/sourcer
```

Alternatively you can set this env var when sourcing `sourcer`
```
DIR_SHELL_LIB=/path/to/lib/dir . /path/to/sourcer
```

Tip: you can put the `sourcer` in your `.bashrc`, so the functions will be available for you on the command line.
