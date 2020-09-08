#!/usr/bin/env bash
# Load the library and application source code into a jshell session.
# NOTE: this is awesome.

jshell \
  --feedback verbose \
  --startup DEFAULT --startup setup-snippets.jsh \
  --class-path 'out:lib/*' \
  --enable-preview
