# GitHub reusable workflows

There are reusable workflows you can use in your CI process.
Some workflows pass default parameters to the tools.
If you don't like that you can pass an empty string (`""`) to override that or set your preferred parameters instead.

---

## reuse-beautysh.yml

Formats Bash shell code with `beautysh`.
Currently only reports on bad formatting, no auto-correction and committing formatted code to repo.

**Parameters**

```
dir:
  description: Directories to look for files
  type: string
  required: true
beautysh_params:
  description: Extra parameters to beautysh
  type: string
  required: false
  default: --force-function-style paronly
```

**Example**

```
name: CI
on:
  pull_request:
    branches:
      - main
jobs:
  format:
    name: Check format with beautysh
    uses: es-progress/shell/.github/workflows/reuse-beautysh.yml@main
    with:
      dir: bin/
      beautysh_params: --force-function-style fnpar --indent-size 2
```

---

## reuse-mkdocs.yml

Deploys documentation created by MkDocs to `gh-pages` branch of the repository.
The deployed site can be accessed using the URL `https://<username>.github.io/<repository>/`, where `<username> `is your GitHub username and `<repository>` is the name of your repo.

You need to have the `mkdocs.yml` file in the root of your repo.
For details check this repo! :smiley:

**Parameters**

```
plugins:
  description: Plugins to install for mkdocs
  type: string
  required: false
  default: mkdocs-literate-nav mkdocs-material mkdocs-minify-plugin mkdocs-git-revision-date-localized-plugin
mkdocs_params:
  description: Extra parameters to 'mkdocs gh-deploy'
  type: string
  required: false
  default: --force --no-history --ignore-version --strict
```

**Example**

```
name: Docs
on:
  pull_request:
    branches:
      - main
    paths:
      - "docs/**"
      - "mkdocs.yml"
jobs:
  deploy:
    name: Deploy docs
    uses: es-progress/shell/.github/workflows/reuse-mkdocs.yml@main
    with:
      plugins: mkdocs-literate-nav
      mkdocs_params: --strict
```

---

## reuse-prettier.yml

Checks code style with `prettier`.

**Parameters**

```
pattern:
  description: File/dir/glob to check
  type: string
  required: true
```

**Example**

```
name: CI
on:
  pull_request:
    branches:
      - main
jobs:
  format:
    name: Check format with prettier
    uses: es-progress/shell/.github/workflows/reuse-prettier.yml@main
    with:
      pattern: "**/*.{md,yml}"
```

---

## reuse-shellcheck.yml

Checks Bash shell code with `shellcheck` linter.

**Parameters**

```
dir:
  description: Directories to look for files
  type: string
  required: true
severity:
  description: Minimum severity of errors to consider (error, warning, info, style)
  type: string
  required: false
  default: style
shellcheck_params:
  description: Extra parameters to shellcheck
  type: string
  required: false
  default: --format gcc --external-sources --shell bash --enable "add-default-case,avoid-nullary-conditions,check-extra-masked-returns,check-set-e-suppressed,deprecate-which,quote-safe-variables,require-double-brackets,require-variable-braces"
```

**Example**

```
name: CI
on:
  pull_request:
    branches:
      - main
jobs:
  linter:
    name: Run shellcheck
    uses: es-progress/shell/.github/workflows/reuse-shellcheck.yml@main
    with:
      dir: bin/
      severity: error
      # Don't pass any exra args to shellcheck
      shellcheck_params:
```
