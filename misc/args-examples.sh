#!/usr/bin/env bash
# Examples of Bash idioms for providing arguments, options, environment variables etc.

# Supply an optional environment variable to override a default value in a script.
#
# To get the default value, execute the script straight up with `./args-examples.sh`
# To override the default value, set the environment variable before executing the script with `MESSAGE="hi there!" ./args-examples.sh`
overrideViaEnvironmentVariable() {
	local message
	if [[ "x$MESSAGE" == "x" ]]; then
		message="hello there!"
	else
		message="$MESSAGE"
	fi

	echo "message: $message"
}
#overrideViaEnvironmentVariable

# A more concise, but more esoteric, version of overrideViaEnvironmentVariable
#
# Reference https://stackoverflow.com/questions/4437573/bash-assign-default-value
overrideViaEnvironmentVariableConcise() {
	: ${MESSAGE:=hello there!}
	echo "message: $MESSAGE"
}
#overrideViaEnvironmentVariableConcise

# Supply arguments from the contents of a file
fromFile() {
	echo $(cat args-examples.sh) | wc
}
fromFile
