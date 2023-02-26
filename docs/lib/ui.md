# User Interface

Bash functions to interact with user on the command line.

---

## Format codes

Color and format codes used by `echo`. They are exporter as env vars, so are available for any other script or function.
Codes can be combined.

```
Font colors:
TXT_RED            Red
TXT_GREEN          Green
TXT_YELLOW         Yellow
TXT_BLUE           Blue
TXT_PURPLE         Magenta

Background colors:
BACK_BLUE          Blue

Other:
TXT_BOLD           Bold fonts
TXT_NORM           Clear all formatting.
                   Useful after formatted text, so next echo prints unformatted chars.
```

**Usage**

```
echo -e "${TXT_BOLD}${TXT_YELLOW}I'm in bold yellow${TXT_NORM} This is unformatted text"
```

---

## cls

Clear console screen. You can't even scroll up after this.

**Usage**

```
cls
```

---

## confirm

Ask for confirmation. If reply is `y` or `Y` return with exit code "0" otherwise non-zero.
Prompt can be configured but I think the default "Are you sure?" covers most situations... :smiley:

**Usage**

```
confirm [PROMPT]

Params:
PROMPT             Question prompt. Defaults to "Are you sure? (y/n) "
```

---

## print-error

Print error message to stderr. Red, bold.

**Usage**

```
print-error MESSAGE

Params:
MESSAGE            Error message
```

---

## print-finish

Print OK message in green with bold letters.

**Usage**

```
print-finish [MESSAGE]

Params:
MESSAGE            Message to print, default: "Done."
```

---

## print-header

Print header: text with yellow font-color after a new-line.

**Usage**

```
print-header HEADER

Params:
HEADER             Header text
```

---

## print-run-time

Print running time of script in a nice summary format.
Seconds converted to hours, mins e.g. 3665 seconds => 1 hour(s) 1 min(s) 5 second(s).
Could be useful for long-running overnight scripts.

**Usage**

```
print-run-time
```

---

## print-section

Print section header: blue background and white letters followed by a line of `=` chars as wide as the header.

**Usage**

```
print-section HEADER

Params:
HEADER             Header text
```

---

## print-status

Print yellow status message. No new line is printed after that so next echo continues on same line!

**Usage**

```
print-status MESSAGE

Params:
MESSAGE            Status message
```
