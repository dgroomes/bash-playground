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
# In this example, we'll find all the files in the current directory using the "ls" command. Then, we'll take the output
# of the "ls" command and pipe it to a "while" loop, looping over it and echoing each line that was output from the "ls"
# command.
#
# File 1: README.md
# File 2: args-examples.sh
# File 3: arrays-examples.sh
# File 4: awk-examples.sh
# File 5: file with spaces in the name.txt
# File 6: find-examples.sh
# File 7: here-doc-examples.sh
# File 8: loop-examples.sh
# File 9: sed-examples.sh
#
# Notice how 'file with spaces in the name.txt' is still intact when it is printed. It is not split on its spaces!
#
# Referenced: https://stackoverflow.com/questions/35927760/how-can-i-loop-over-the-output-of-a-shell-command
loopOverOutput() {
	local idx=1
	ls | while read -r file; do
		echo "File $idx: $file"
		idx=$((idx + 1))
	done
}
#loopOverOutput

# Loop over output from another command using Bash arrays.
#
# Similar to loopOverOutput but saving the output into a Bash array instead of piping it to a while loop. It's
# necessary to set IFS so that files with spaces in the name are accommodated.
#
# Referenced: https://stackoverflow.com/a/9449633
loopOverOutputWithArray() {
	IFS=$'\n'
	local files=( $(ls) )
	unset IFS

	local idx=1
	for file in "${files[@]}"; do
		echo "File $idx: $file"
		idx=$((idx + 1))
	done
}
#loopOverOutputWithArray

# Loop over the content of a file, line-by-line.
loopOverFileContent() {
	local idx=1
	while read -r line; do
		echo "Line $idx: $line"
		idx=$((idx + 1))
	done < "README.md"
}
loopOverFileContent
