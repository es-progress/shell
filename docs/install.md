# Installation

Library functions are organized by category into smaller files (`lib/*.sh`), so they're easier to manage.
Functions often depend on each other, making it necessary to source several files to define all functions.

Yet it's possible to include only the necessary lib files in a script, it's generally easier to load them all.
For this purpose there is a loader (`lib/_loader.sh`). Simply source this file, and it will automatically source all other libraries.

In the supplied scripts (`bin/`), the loader is referenced by an environment variable (`ES_SHELL_LOADER`).
It's recommended to use this env var in your scripts as well.

For detailed instructions on using the loader, check [Reference](lib/_loader.md).

**Installation steps**

1. Clone Git repository
    ```bash
    git clone https://github.com/es-progress/shell.git SHELL_DIR
    ```
1. Set `ES_SHELL_LOADER` to point to `lib/_loader.sh`. It's best to add this to your `.bashrc`.
    ```bash
    export ES_SHELL_LOADER="SHELL_DIR/lib/_loader.sh"
    ```
1. (Optional) Add `bin` to your `PATH` to run scripts by name
    ```bash
    PATH="SHELL_DIR/bin:${PATH}"
    ```

!!! tip

    Source loader in your `.bashrc` and all functions will be ready to use in your terminal.
    In fact, some of them are for interactive use on the command line!
