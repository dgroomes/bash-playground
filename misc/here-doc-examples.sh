#!/usr/bin/env bash
# Here document (here doc) examples
# https://tldp.org/LDP/abs/html/here-docs.html

# A prototypical "here doc" to the 'cat' program. A here doc is a convenient way to author and print a block of text
# without having to deal with quotes.
#
# Notice how the content of the here doc is printed with its indentation preserved. So, unfortunately there is a
# trade-off to be made between how you want to format your code (preferably *with* indents) and how you want your here
# doc to print (preferably *without* indents).
hereDoc() {
  cat << EOF
hello there
	I will be indented
EOF
}
#hereDoc

# A here doc but to the "wc" program. You can do a here doc to any program! Wait... does a here doc work like a pipe or
# like IO redirection? Or am I getting confused?
hereDocToWc() {
  wc -l << EOF
hello there
EOF
}
#hereDocToWc

# This is cool. The "<<-" form will strip the leading tabs. This is a convenient feature that let's us indent the code
# for readability. After all, in almost every other programming language (or all of them?), we indent the code inside of
# a function block, so why do it any differently in Bash code?
hereDocStripTabs() {
  cat <<- EOF
		hello there. I will *not* be indented!
	EOF
}
#hereDocStripTabs

# Here docs can be used in a pipeline.
# This is contrived example, but it takes a give here doc and applies it to a pipeline of two commands: 1) awk 2) wc
# If more steps in the pipeline are needed, then simply add them to the right of the last command (wc) and if more here
# docs are needed simply add them below the last command (wc). In this manner, we can extend the statement downward and
# to the right which is a natural way to model a pipeline.
# Referenced material: https://stackoverflow.com/questions/7046381/multiline-syntax-for-piping-a-heredoc-is-this-portable
hereDocPipeline() {
	awk '{ $2=sprintf("%02d", $2); }1' <<- EOF |
	1	2	3
	EOF
	wc -c
}
hereDocPipeline
