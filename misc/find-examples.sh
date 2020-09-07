#!/usr/bin/env bash
# Examples of the 'find' command. Learning and exploring 'find'.

# To exercise the 'find' command we need a playground directory that contains other files and directories with some
# amount of nested content and a variety of naming. Instead of creating dummy directories and files we will just use the
# root directory of this 'shell-playground' repository.
ROOT_DIR=$(cd .. && pwd)

# List top level directories.
function topLevelDirectories() {
  find "$ROOT_DIR" -type d -depth 1
}

# List second level directories.
function secondLevelDirectories() {
  find "$ROOT_DIR" -type d -depth 2
}

# List files that are non-hidden (i.e. files that do not begin with a '.')
# For example, do not list '.git' or '.gitignore'.
#
# Importantly, this incantation of 'find' will filter out hidden files in the top-level and in sub-directories. It's
# necessary to write the '-path' expression to accommodate that requirement. See https://askubuntu.com/a/318211
# and for an even more portable (but less self-describing) method see https://askubuntu.com/a/749708
function nonHiddenFiles() {
  find "$ROOT_DIR" -not -path '*/\.*'
}

