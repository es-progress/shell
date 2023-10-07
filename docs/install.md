# Installation

Library functions are organized by category into smaller files (`lib/*.sh`) so they're easier to manage.
Usually functions use each other, so this makes using them a bit harder as several files need to be sourced in order to define all functions.

Yet it's possible to include only the lib files you need in a script, it's generally easier to load them all.
For this purpose there is a loader (`lib/_loader.sh`). Simply source this file, and it will automatically source all other libraries.

In supplied scripts (`bin/`) loader is referenced by an environment variable (`ES_SHELL_LOADER`).
It's recommended to use this env var in your scripts also.

For detailed instructions on using the loader check [Reference](lib/_loader.md).

**Installation steps**

1. Clone Git repository
    ```
    git clone https://github.com/es-progress/shell.git SHELL_DIR
    ```
1. Set `ES_SHELL_LOADER` to point to `lib/_loader.sh`. Best to put this in your `.bashrc`.
    ```
    export ES_SHELL_LOADER="SHELL_DIR/lib/_loader.sh"
    ```
1. (Optional) Add `bin` to your `PATH` so you can run scripts just by name
    ```
    PATH="SHELL_DIR/bin:${PATH}"
    ```

!!! tip

    Source loader in your `.bashrc` and all functions are ready to use in your terminal.
    Actually some of them are meant for interactive use on the command line!
