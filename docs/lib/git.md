# Git

Wrappers and helpers for `git`.

---

## ggit-adog

Show git log as a nice graph.

**Usage**

```
ggit-adog
```

---

## ggit-base

Rebase source onto target and forcefully push rebased branch to the remote repository.

**Usage**

```
ggit-base SOURCE [TARGET] [REMOTE]

Params:
SOURCE             Branch to rebase
TARGET             Rebase onto this branch. Defaults to 'main'.
REMOTE             Remote repository to pull and push. Defaults to 'origin'.
```

---

## ggit-diff

Show a summarized difference: list changed files and the number of changed lines.

**Usage**

```
ggit-diff BRANCH_A BRANCH_B

Params:
BRANCH_A           Branch to compare to
BRANCH_B           Branch to compare with
```

---

## ggit-fix

Start interactive rebase to change history: squash, reorder and delete commits, change commit message, etc.
Need to specify how many commits to involve from HEAD. Giving "1" means edit last commit.

**Usage**

```
ggit-fix COMMITS

Params:
COMMITS            Numer of commits to go back from HEAD
```

---

## ggit-merge

Merge the source branch into the target branch (performs a fast-forward merge). This includes several steps:

1. Checkout _source_ branch and pull remote changes from remote repo
1. Checkout _target_ branch and pull remote changes from remote repo
1. Merge source branch
1. Push target branch
1. Delete merged branches (local & remote tracking)

**Usage**

```
ggit-merge SOURCE [TARGET] [REMOTE]

Params:
SOURCE             Branch to be merged
TARGET             Branch to merge into. Defaults to 'main'.
REMOTE             Remote repository to pull and push. Defaults to 'origin'.
```

---

## ggit-patch

Create patch from any commit and apply to HEAD.

**Usage**

```
ggit-patch SHA...

Params:
SHA                Create patch from this commit specified by SHA
```

---

## ggit-pull

Pull the local branch from the remote repository, also updating any submodules.

**Usage**

```
ggit-pull [BRANCH] [REMOTE]

Params:
BRANCH             Branch to pull. Defaults to 'main'.
REMOTE             Remote repository to pull. Defaults to 'origin'.
```

---

## ggit-report

Show git status, list all branches and remotes.

**Usage**

```
ggit-report
```

---

## ggit-stat-daily

Show commit statistics: number of commits grouped by hour of the day.

**Usage**

```
ggit-stat-daily
```

---

## ggit-stat-monthly

Show commit statistics: number of commits grouped by day of the month.

**Usage**

```
ggit-stat-monthly
```

---

## ggit-stat-weekly

Show commit statistics: number of commits grouped by day of the week.

**Usage**

```
ggit-stat-weekly
```

---

## ggit-tag

Create a signed tag & push to remote.

**Usage**

```
ggit-tag NAME [COMMIT] [MESSAGE] [REMOTE]

Params:
NAME               Tag name
COMMIT             Commit to tag. Defaults to HEAD.
MESSAGE            Tag message. Defaults to same as tag name.
REMOTE             Remote repository to push. Defaults to 'origin'.
```

---

## ggit-update

**WARNING**: this is a forced operation, local branch will be deleted!

Update local branch from remote.
It deletes and recreates the branch from remote, rather than doing a rebase or some merge/pull.
This comes handy if a branch was rebased on remote and a simple pull is not working.
This way you can have the same commits (and history) as remote.

**Usage**

```
ggit-update BRANCH [REMOTE]

Params:
BRANCH             Branch to update
REMOTE             Remote repository, defaults to 'origin'.
```

---

## ggit-version

Create & push a new version tag to remote.
Version tag format is: `vx.y.z` (semantic versioning).
Next version number is deducted from last version tag with specified part bumped (major, minor or patch).

**Usage**

```
ggit-version PART [COMMIT] [REMOTE]

Params:
PART               Which part of the version to increase (major, minor, patch)
COMMIT             Commit to tag. Defaults to HEAD.
REMOTE             Remote repository to push. Defaults to 'origin'.
```
