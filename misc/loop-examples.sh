#!/usr/bin/env bash
# Examples with loops

# for integer range
forIntegerRange() {
	for i in {1..5} ; do
	    echo "$i"
	done
}
#forIntegerRange

# This does NOT WORK. It doesn't expand correctly. It prints
# 	{1..6}
# Why? I'm not really sure but there is a lot of discussion about it at https://stackoverflow.com/q/169511
forIntegerRangeFromVariable() {
	local max=6
	for i in {1..$max} ; do
	    echo "$i"
	done
}
#forIntegerRangeFromVariable

# Basic for loop
forI() {
	for (( i = 0; i < 5; i++ )); do
	    echo "$i"
	done
}
#forI

# Loop over output from another command.
#
# In this example, we'll find all the files in the current directory using the "ls" command.
# Then, we'll take the output of the "ls" command and loop over it using Bash array syntax. Thankfully, this function
# will handle file names with spaces in the name! The output of the function will be something like
# README.md
# args-examples.sh
# arrays-examples.sh
# awk-examples.sh
# file with spaces in the name.txt
# find-examples.sh
# here-doc-examples.sh
# loop-examples.sh
# sed-examples.sh
#
# Notice how 'file with spaces in the name.txt' is still intact when it is printed. It is not split on its spaces! See
# the 'arrays-examples.sh' file for more info on Bash arrays.
loopOverOutput() {
	files=$(ls)
	for i in "${files[@]}"; do
		echo "$i"
	done
}
loopOverOutput
