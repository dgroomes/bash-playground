#!/usr/bin/env bash
# Examples that print to the terminal in a fancy way

# Taken from https://stackoverflow.com/a/238094
function progressBarEcho() {
	echo -ne '##         (20%)\r'
  sleep .5
  echo -ne '#####      (50%)\r'
  sleep .5
  echo -ne '########   (80%)\r'
  sleep .5
  echo -ne '#########  (90%)\r'
  sleep .5
  echo '########## (100%)'
}
#progressBarEcho

# Create a spinner animation using 'printf'
# Taken from https://stackoverflow.com/a/3330834
function spinnerPrintf() {
	i=1
  sp="/-\|"
  echo -n ' '
  while true
  do
      printf "\b${sp:i++%${#sp}:1}"
      sleep .05
  done
}
#spinnerPrintf

# Do some fancy printing by moving the cursor around.
# We use ANSI escape sequences to control the cursor.
#
# See https://en.wikipedia.org/wiki/ANSI_escape_code
#
# Warning: this doesn't work very well but it does move the cursor around. This stuff is confusing.
function cursorControl() {

  # Print 'Cake'
	echo -ne '[3;1H'
	echo -ne 'C'
	echo -ne 'a'
	echo -ne 'k'
	echo -ne 'e'
	sleep .5

  # Replace the first character ('C') with 'L' to spell 'Lake'
	echo -ne '[3;1H'
	echo -ne 'L'
	sleep .5

  # Replace the first character ('L') with 'B' to spell 'Bake'
	echo -ne '[3;1H'
	echo -ne 'B'
	sleep .5

  # Replace the first character ('B') with 'T' to spell 'Take'
	echo -ne '[3;1H'
	echo -e 'T'
	sleep .5
}
cursorControl
