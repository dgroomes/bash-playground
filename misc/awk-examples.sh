#!/usr/bin/env bash
# Examples using the 'awk' program
# Referenced material:
#  * https://www.gnu.org/software/gawk/manual/html_node/ARGC-and-ARGV.html
#  * https://www.gnu.org/software/gawk/manual/html_node/Quoting.html
#  * https://www.gnu.org/software/gawk/manual/html_node/For-Statement.html
#  * https://www.gnu.org/software/gawk/manual/html_node/Concatenation.html

replace() {
	echo "hello there, %PLACEHOLDER%" | awk '{ gsub(/%PLACEHOLDER%/,"friend") }1'
}
#replace

# Pass variables to 'awk' with the '-v' option.
replaceWithVariable() {
	echo "hello there, %PLACEHOLDER%" | awk -v subject='friend' '{ gsub(/%PLACEHOLDER%/,subject) }1'
}
#replaceWithVariable

# An alternative to 'awk' variables are 'awk' *arguments*. Arguments in awk are given as positional arguments.
printWithArg() {
	local message="hello there"
	awk 'BEGIN{s=ARGV[1]; print s }' "$message"
}
#printWithArg

# This fails. You cannot use multiline strings in awk variables. Why? I'm not really sure, but it just isn't supported
# in macOS/BSD 'awk'. Read a mention about this at https://stackoverflow.com/a/50556484
#
# This function will fail with the following message:
#  awk: newline in string i am on
#  multiple lin... at source line 1
printWithVariableMultiline() {
	local message
	message="i am on
multiple lines"

	awk -v message="$message" 'BEGIN{ print v }'
}
#printWithVariableMultiline

# By contrast, it *is possible* to use multiline strings in awk arguments.
printWithArgMultiline() {
	local message
	message="i am on
multiple lines"
	awk 'BEGIN{s=ARGV[1]; ARGV[1]=""; print s }' "$message"
}
#printWithArgMultiline

# Replace content from standard input with an 'awk' argument.
#
# WARNING: this is quite verbose. If you can afford to, you should consider using 'sed' for simple string substitutions.
# However, if you need the extra power of 'awk' you can use this pattern. For example, 'awk' allows substitution with
# multiline strings whereas sed has some drawbacks with this. See https://stackoverflow.com/questions/10107459/replace-a-word-with-multiple-lines-using-sed
#
# What is the meaning of the "-" argument to 'awk'? It tells awk to use standard input instead trying to read from a file.
#
# What is the purpose of re-assigning ARGV[2] to an empty string ""? If, you don't re-assign it, then 'awk' will try to
# actually read a file of the name given by ARGV[2]. So in this case, it would try to read a file named 'friend'. This
# is not what we want. We just want to use 'friend' as the value for an argument. If we did not re-assign ARGV[2], then
# awk would print the following error message:
#   awk: can't open file friend
#    input record number 1, file friend
#    source line number 1
replaceWithArg() {
	echo "hello there, %PLACEHOLDER%" | awk 'BEGIN{ subject=ARGV[2]; ARGV[2]=""; } { gsub(/%PLACEHOLDER%/,subject) }1' - friend
}
#replaceWithArg

leftPad() {
	echo $"1 22 333 4444" | awk '
  {
    $1=sprintf("%04d", $1);
    $2=sprintf("%04d", $2);
    $3=sprintf("%04d", $3);
    $4=sprintf("%04d", $4);
    print
  }'
}
#leftPad

# A no-arg invocation of awk. This is an unusual use case. It doesn't actually process any input! Why would you want to
# use this? You might want to use awk to generate data or you would prefer to hardcode what would be the input data into
# your awk script itself.
noArg() {
	awk '
		BEGIN {
		  sum = 1 + 2;
			printf "I used awk to do a hardcoded arithmetic operation. The result: %d\n", sum;
		}
	'
}
#noArg

# Generate a large sample of JSON-formatted data for testing purposes.
# This is much faster than using a bash for loop.
generateTestData() {
	# A template string that will be used in a printf command inside awk. It is convenient to declare the template string
	# in a bash expression because we have the convenience of using single quotes (')  that let's us express the JSON
	# fields without an extra quoting burden. In awk, all strings must be expressed using double quotes (like most
	# programming languages) and we can't use that trick.
	local jsonTemplate='{ "x": %d, "y": %d }'
	local numberOfLines=3
	awk \
		-v jsonTemplate="$jsonTemplate" \
		-v numberOfLines=$numberOfLines '
		BEGIN {
			for (i = 1; i <= numberOfLines; i++) {
				x = i;
				y = numberOfLines - x;
				printf jsonTemplate "\n", x, y;
			}
		}
	'
}
generateTestData
