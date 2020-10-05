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
forI