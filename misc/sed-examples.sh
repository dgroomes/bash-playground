#!/usr/bin/env bash
# Examples using the 'sed' program

replaceFromEcho() {
  echo "hello there, PLACEHOLDER" | sed s/PLACEHOLDER/friend/
}
#replaceFromEcho

replaceFromFile() {
  cat README.md | sed s/misc/MISC/
}
#replaceFromFile

# Include multiple "commands".
#
# Why is the option named 'e' if it is for "commands"? I bet it started off as meaning "expressions" but interestingly
# the man page for sed for the '-e' option describes it as a command not an expression.
#
# Also, this function reminds you that "you just need to quote stuff sometimes (or, a lot of the time!)".
replaceMultiple() {
  cat README.md |\
  sed \
    -e s/misc/MISC/ \
    -e "s/content/content and other stuff/"
}
#replaceMultiple

# This DOES NOT WORK. sed will error with this message:
#   sed: 1: "s/%MESSAGE%/today is a  ...": unescaped newline inside substitute pattern
#
# This is a shortcoming of sed. See https://stackoverflow.com/questions/10107459/replace-a-word-with-multiple-lines-using-sed
# Consider using the 'awk' program instead. See https://stackoverflow.com/a/10107668
replaceWithMultilineString() {
  local msg="today is a day.
tomorrow is another day."

  echo "here is a message: %MESSAGE%" | sed "s/%MESSAGE%/$msg/"
}
#replaceWithMultilineString

# Replace a string with the full contents of a file.
# This will unfortunately add the file content on a new line after the line that was matched.
replaceWithFileContents() {
	cat README.md | sed '/content/{
	  s/content//g
	  r sed-examples.sh
	}'
}
replaceWithFileContents
