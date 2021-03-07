# Bash shell scripts & functions

## Overview
This is a collection of utility scripts and helper functions.

You can find the scripts in the `bin/` directory and the function libraries in the `lib/` dir.

For details please check the documentation.

## Usage
Most scripts use functions from the libraries, so they need to get sourced inside the scripts, to be available.
For this there is the `sourcer`. All it does is include every library file from the `lib` dir.
So if you need the libraries, all you have to do is to include (source) the `sourcer` script, and it does the job.

For it to work it uses an environment variable (`DIR_SHELL_LIB`) to get the path of the `lib` directory.
```
. /path/to/sourcer
```

Alternatively you can set this env var when sourcing `sourcer`
```
DIR_SHELL_LIB=/path/to/lib/dir . sourcer
```

Tip: you can put the `sourcer` in your `.bashrc`, so the functions will be available for you on the command line.
