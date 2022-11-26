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

Rebase source onto target and force-push rebased branch to remote.

**Usage**

```
ggit-base SOURCE TARGET REMOTE

Params:
SOURCE             Branch to rebase
TARGET             Rebase onto this branch. Defaults to 'main'.
REMOTE             Remote repository to pull and push. Defaults to 'origin'.
```

---

## ggit-diff

Show only a summarized diff: list changed files and number of changed lines.

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

Merge source branch into target branch. This includes several steps:

1. Checkout _source_ branch and pull remote changes from remote repo
1. Checkout _target_ branch and pull remote changes from remote repo
1. Merge source branch
1. Push target branch
1. Delete merged branches (local & remote tracking)

**Usage**

```
ggit-merge SOURCE TARGET REMOTE

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
ggit-patch SHA

Params:
SHA                Create patch from this commit specified by SHA
```

---

## ggit-pull

Pull local branch from remote. Also update submodules.

**Usage**

```
ggit-pull BRANCH REMOTE

Params:
BRANCH             Branch to pull. Defaults to 'main'.
REMOTE             Remote repository to pull and push. Defaults to 'origin'.
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
