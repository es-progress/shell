# Loader

Helper to bootstrap libraries. This file sources all library files so functions will be defined and available.
Basically, you need to source this file in any script where you want to use library functions.

**Usage in scripts**

```bash
# Source loader
. /path/to/shell/lib/_loader.sh

# Or use the envvar (recommended for maintainability & portability)
. "${ES_SHELL_LOADER}"

# Now functions are defined
check-root
error-exit "Nothing to do"
```

If you do the envvar way, you need to set `/path/to/shell/lib/_loader.sh` in `ES_SHELL_LOADER`.
You can do this in `.bashrc` or just when running a script:

```bash
ES_SHELL_LOADER=/path/to/lib/_loader.sh backup
```

!!! tip

    Source loader in your `.bashrc` and all functions are ready to use in your terminal.
    Actually some of them are meant for interactive use on the command line!

You can read more about bootstrapping in [Installation instructions](../install.md).
