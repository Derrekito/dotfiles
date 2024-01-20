#!/bin/bash

FILE="$1"

# ensure space between parenthesis and m/calloc
sed -E -i.bak 's/\)(malloc|calloc)\b/\) \1/g' "$FILE"

# eplace commas and semicolons that are followed by a non-whitespace character, but not at the end of a line
sed -i 's/[;,]\(?!$|\s\)\([^[:space:]]\)/, \2/g' "$FILE"

awk '
  BEGIN { in_block = 0 }
  {
    if (/^\s*{/ && !in_block) {
      print ""
      in_block = 1
    }
    else {
      in_block = 0
    }
    print
  }' "$FILE"> temp_linted.c

mv temp_linted.c "$FILE"
