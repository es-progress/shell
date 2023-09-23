# GitHub

Wrapper for GitHub CLI tool: `gh`.

---

## ghub-foreach-owner

Run `gh` command for each repository of user. Useful to run any other function in this category for each repo.
E.g. Open all repository in browser: `ghub-foreach-owner OWNER ghub-open`.

**Usage**

```
ghub-foreach-owner OWNER COMMAND [ARGS]...

Params:
OWNER              Owner, GitHub user or organization
COMMAND            Command to run for each repo
ARGS               Optional extra params to COMMAND.
                   REPO is always passed to COMMAND as first argument.
```

---

## ghub-foreach-topic

Run `gh` command for each repository of user, filtered by topic.
Useful to run any other function in this category for each repo.
E.g. Sync labels from master repo: `ghub-foreach-topic OWNER TOPIC ghub-sync-labels TEMPLATE`.

**Usage**

```
ghub-foreach-topic OWNER TOPIC COMMAND [ARGS]...

Params:
OWNER              Owner, GitHub user or organization
TOPIC              Match repos only with this topic
COMMAND            Command to run for each matched repo
ARGS               Optional extra params to COMMAND.
                   REPO is always passed to COMMAND as first argument.
```

---

## ghub-get

Get names of all repos for a GitHub account.
Names are returned as a list, each repo on a separate line.
Useful for completion scripts for other functions in this category.

**Usage**

```
ghub-get OWNER [EXTRA]...

Params:
OWNER              Owner, GitHub user or organization
EXTRA              Optional extra params to 'gh'
```

---

## ghub-issue

Create issue for repository and open in browser.

**Usage**

```
ghub-issue REPO [EXTRA]...

Params:
REPO               GitHub repository, given as "owner/repo-name".
                   Default to repository in current working dir.
EXTRA              Optional extra parameters to 'gh'
```

---

## ghub-list

Listing of repos for a GitHub account.

**Usage**

```
ghub-list OWNER [EXTRA]...

Params:
OWNER              Owner, GitHub user or organization
EXTRA              Optional extra params to 'gh'
```

---

## ghub-open

Open GitHub repository page in web browser.

**Usage**

```
ghub-open REPO [EXTRA]...

Params:
REPO               GitHub repository, given as "owner/repo-name".
                   Default to repository in current working dir.
EXTRA              Optional extra params to 'gh'
```

---

## ghub-pr

Create PR (pull request) in browser for current repository (repo in working dir).

**Usage**

```
ghub-pr TITLE BODY [EXTRA]...

Params:
TITLE              PR title
BODY               PR body: a string or a file that contains the body
EXTRA              Optional extra params to 'gh'
```

---

## ghub-repo-clone

Clone repository.

**Usage**

```
ghub-repo-clone REPO [EXTRA]...

Params:
REPO               Desired GitHub repository name, given as "owner/repo-name"
EXTRA              Optional extra params to 'gh'
```

---

## ghub-repo-new

Create new repository.

**Usage**

```
ghub-repo-new REPO [EXTRA]...

Params:
REPO               Desired GitHub repository name, given as "owner/repo-name"
EXTRA              Optional extra params to 'gh'
```

---

## ghub-repo-template

Create new private repository from GitHub template repository.

**Usage**

```
ghub-repo-template REPO TEMPLATE [TOPIC]...

Params:
REPO               Desired GitHub repository name, given as "owner/repo-name"
TEMPLATE           Template GitHub repository, given as "owner/repo-name"
TOPIC              Topics to add to repo
```

---

## ghub-secret-set

Set a repository secret for GitHub Actions.

**Usage**

```
ghub-secret-set REPO NAME VALUE [EXTRA]...

Params:
REPO               GitHub repository, given as "owner/repo-name"
NAME               Secret name
VALUE              Secret value
EXTRA              Optional extra params to 'gh'
```

---

## ghub-settings

Open GitHub repository settings page in web browser.

**Usage**

```
ghub-settings REPO [EXTRA]...

Params:
REPO               GitHub repository, given as "owner/repo-name".
                   Default to repository in current working dir.
EXTRA              Optional extra params to 'gh'
```

---

## ghub-sync-config

Update configs to default values.

**Usage**

```
ghub-sync-config REPO [EXTRA]...

Params:
REPO               GitHub repository, given as "owner/repo-name"
EXTRA              Optional extra params to 'gh'
```

---

## ghub-sync-labels

Sync labels from template repository to target repository.
Non-existent labels will be created, extra ones deleted, different ones updated to match template.
After this operation labels will the same as the template. Matching is based on label name.

**Usage**

```
ghub-sync-labels REPO TEMPLATE

Params:
REPO               GitHub repository, given as "owner/repo-name" to sync
TEMPLATE           GitHub repository, given as "owner/repo-name" used as template for syncing
```

---

## ghub-topic

Add topic(s) to repository.

**Usage**

```
ghub-topic REPO [TOPIC]...

Params:
REPO               GitHub repository, given as "owner/repo-name"
TOPIC              Topics to add to repo
```
