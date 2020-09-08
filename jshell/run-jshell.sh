#!/usr/bin/env bash
# NOT YET FULLY IMPLEMENTED
# Load the source code into a jshell session
# WARNING: I can't get jshell to load the application source code and the jars. I should be able to use something like
# `jshell -cp 'out:lib/*'` (inspired by my other project https://github.com/dgroomes/simple-java-web-app/blob/main/run.sh#L4)
# but for some reason it complains with "File 'p' for '--class-path' is not found."

jshell --class-path 'lib/*' --enable-preview
