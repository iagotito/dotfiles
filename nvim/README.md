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

## Copy, cut and paste

> obs.: delete in vim copy the deleted content to a register that 
> is used by the yank and paste commands, so the delete is actually 
> a cut.

Command | Effect
:-----: | ------
`y` | `y`ank visual selection (copy)
`yw` / `yb` | `y`ank `w`ord forward or `b`ackward
`d` / `x` | `d`elete visual selection
`dw` / `db` | `d`elete `w`ord forward or `b`ackward
`s` | delete visual selection or character and enters in _insert_ mode
`x` / `<delete>` | delete character on right
`X` | delete character on left
`dd` | `d`elete line
`yy` | `y`ank line (copy line)
`p` | paste register content one line below
`P` | paste register content one line above
`"*y` / `"+y` | `y`ank to system clipboard
`"*p` / `"+p` | `p`aste from system clipboard

