---
title: "Vim Command Mode"
tags: ["vim"]
created: "20220310202038225"
modified: "20220326173944010"
---

## Explore
- `%` the current file
- `#` previous file
- `<C-Shift-6>` to jump to the previous file

## Splits
- `<C-w>v` - open a vertical split
- `<C-w>s` - open a horizontal split
- `<C-w>o` - only keep the current split

## Manipulate Numbers
- `<C-a>` to auto increment a number
- `<C-x>` to auto decrement a number

## Find in line
- `f` jump to a character in a line ; for next match , for prev
- `t` jump up to a character

## Change Text
- `D` to delete to end of the line
- `C` to change to end of the line
- `S` delete the whole line respect indenting and go into insert
- `s` like x but goes into insert mode

## Jumps
- `_` first non whitespace character on a line
- `{` and `}` jump between paragraphs
- `[m` and `]m` jump between opening and closing braces
- `[M` and `]M`
- `%` to jump between matching braces

## Motions
- `di{` delete in `{}`
- `da{` delete the `{}` as well
- `o` to jump between the lines of the visual selection block
- `viw` to select within word
- `viW` to select in all non-whites pace
