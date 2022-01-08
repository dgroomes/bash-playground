#!/usr/bin/env bash
# Examples that print to the terminal in fancy way

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
spinnerPrintf
