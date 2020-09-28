#!/usr/bin/env bash
# Examples with arrays
# I don't want to reinvent the wheel here. Please get a copy of the excellent book "The Linux Command Line, 2nd Edition"
# and refer to "Chapter 35: Arrays". https://learning.oreilly.com/library/view/the-linux-command/9781492071235/xhtml/ch35.xhtml#ch35

# Loop through an array. This function will print:
#   hippo
#   giraffe
#   sea
#   turtle
#
# BE CAREFUL! This illustrates a word splitting surprise with the 'sea turtle' array element
loop() {
  arr=(hippo giraffe "sea turtle")

  for i in ${arr[*]}; do
    echo "$i"
  done
}
#loop

# Loop through an array using a more idiomatic form: double quote the array and use '@' instead of '*'. This function
# will print:
#   hippo
#   giraffe
#   sea turtle
loop2() {
  arr=(hippo giraffe "sea turtle")

  for i in "${arr[@]}"; do
    echo "$i"
  done
}
loop2
