# Text processing

Bash functions for text processing & strings.

---

## implode

Concatenate arguments using a specified joining character, similar to how it's done in other programming languages.
This can be useful to create e.g. comma-delimited list from an array of names.

**Usage**

```
implode CHAR [ITEM]...

Params:
CHAR               Joining character
ITEM               Strings to join
```

---

## lines-dir

Count total lines of all files in a directory. Works well only with text files.
If you're curious how many lines of code in that `src/` dir...

**Usage**

```
lines-dir DIR [EXTRA]...

Params:
DIR                Directory to count
EXTRA              Optional extra params to 'find'
```

---

## read-file-cfg

Read a config file. Blank lines (consisting only whitespace) and comments (lines started with `#`) are removed.
Sections are marked with square brackets and you can select to return all sections or just one.
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
