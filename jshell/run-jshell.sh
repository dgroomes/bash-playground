#!/usr/bin/env bash
# Load the library and application source code into a jshell session.
# NOTE: this is awesome.

jshell \
  --feedback verbose \
  --class-path 'out:lib/*' \
  --enable-preview
