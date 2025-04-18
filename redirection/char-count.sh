#!/usr/bin/env bash
#
# Counts the number of characters input from standard in. This is just a vehicle for us to show redirection in the
# 'capture.sh' script.
#
# This also logs a debug-like message to standard error.
#
# Example:
#   $ echo "hello there, world!" | ./char-count.sh
#   DEBUG: Counting 'hello...'
#   19

input=$(cat)
char_count=${#input}
preview="${input:0:5}..."
echo "DEBUG: Counting '${preview}'" >&2
echo "$char_count"
