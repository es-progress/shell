# Text processing

Bash functions for text processing & strings.

---

## implode

Concatenate arguments using a specified joining character, similar to other programming languages.
This can be useful to create, e.g. a comma-delimited list from an array of names.

**Usage**

```
implode CHAR [ITEM]...

Params:
CHAR               Joining character
ITEM               Strings to join
```

---

## lines-dir

Count total lines of all files in a directory. This function works well only with text files.
If you're curious about how many lines of code are in that `src/` dir...

**Usage**

```
lines-dir DIR [EXTRA]...

Params:
DIR                Directory to count
EXTRA              Optional extra params to 'find'
```

---

## read-file-cfg

Read a config file. Blank lines (consisting only of whitespace) and comments (lines starting with `#`) are removed.
Sections are marked with square brackets, and you can choose to return all sections or just one.
Content inside sections are returned unparsed, so format is up to you (square brackets: `[`, `]` can't be used though).

Config file example:

```ini
# This is a comment

  # Whitespace allowed before comments
[section]
some options
format=no
which;is;best;suited
[other section]
```

**Usage**

```
read-file-cfg FILE [SECTION]

Params:
FILE               Config file to parse
SECTION            Optional section. If specified read only this section.
```

---

## urldecode

Decode URL-encoded strings.

**Usage**

```
urldecode STRING

Params:
STRING             URL-encoded string
```

---

## urlencode

URL-encode strings.

**Usage**

```
urlencode STRING

Params:
STRING             String to encode
```
