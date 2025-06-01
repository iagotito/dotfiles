# VIM Cheatsheet

## Exiting

Command | Effect
:-------: | ------
`:q` | `q`uit current window
`:q!` / `ZZ` | `q`uit current window, abandon changes
`:w` | `w`rite changes
`:wq` | `w`rite changes and `q`uit
`:x` / `ZZ` | save changes if modified and quit
`:qa` | `q`uit `a`ll windows
`:qa!` | `q`uit `a`ll windows, abandon changes

## Exiting insert mode

Command | Effect
:-------: | ------
`Esc` / `<C-[>` | exit insert mode
`<C-c>` | exit insert mode and abort current command

## Visual Mode

Command | Effect
:-----: | ------
`v` | Enter visual mode
`V` | Enter visual line mode
`<C-v>` | Enter visual block mode

## Navigating

### Basic navigation

Command | Effect
:-----: | ------
`h` `j` `k` `l` | move left, down, up, right
`w` | hop forward by a `w`ord
`b` | hop `b`ackwards by a word
`e` | hop forward to the `e`nd of the word
`ge` | hop backward to the `e`nd of the word
`<C-u>` / `<C-d>` | move half-page up/down
`<C-b>` / `<C-f>` | move page up/down

### Horizontal navigation

Command | Effect
:-----: | ------
`f`_*_ / `F`_*_ | jump to character _*_ forward and backward (`f`ind character)
`t`_*_ / `T`_*_ | jump up `t`o character _*_ forward and backward, but not on character
`;` | iter through the find results of the above commands

### Vertical navigation

Command | Effect
:-----: | ------
`:`N / N`G` | go to line N
`gg` / `G` | move to start / end of the file
N`k` / N`j` | move N lines up/down (repeat `k`/`j` command N times)
`{` / `}` | hop up/down by paragraph (hop up/down to next blank line)
`%` | move to matching pair (parentheses, brackets, braces, but not quotes)

## Copy, cut and paste

> obs.: delete in vim copy the deleted content to a register that
> is used by the yank and paste commands, so the delete is actually
> a cut.

Command | Effect
:-----: | ------
`y` | `y`ank visual selection (copy)
`d` / `x` | `d`elete visual selection
`c` | delete visual selection and enters _insert_ mode
`s` | delete visual selection or character and enters in _insert_ mode
`x` / `<delete>` | delete character on right
`X` | delete character on left
`D` | `D`elete until the end of the line
`C` | Delete until the end of the line and enters _insert_ mode
`S` | Delete entire line and enters _insert_ mode
`dd` | `d`elete line
`yy` | `y`ank line (copy line)
`<command>i<pair character>` | apply command inside matching pairs
`<command>a<pair character>` | apply command inside matching pairs, including pair
`<command>iw` | apply command to current word
`<command>iP` | apply command inside paragraph
`p` | paste register content one line below
`P` | paste register content one line above
`"*y` / `"+y` | `y`ank to system clipboard
`"*p` / `"+p` | `p`aste from system clipboard

The `y`, `w`, `c`, `x` etc commands can be combined with the navigation
commands to apply them through the navagation. For example:

Command | Effect
:-----: | ------
`dw` / `db` | `d`elete `w`ord forward or `b`ackward
`d3w` | `d`elete `3` `w`ords forward
`d3j` | `d`elete `3` lines down
`df`c | `d`elete until `f`ind the character c
`dt`c | `d`elete up `t`o character c, but not it
`dG` | delete all lines until the end of the file
