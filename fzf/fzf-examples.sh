#!/usr/bin/env bash
# Examples of the 'fzf' command. Learning and exploring its range of motion.

# To exercise the 'find' command we need a playground directory that contains other files and directories with some
# amount of nested content and a variety of naming. Instead of creating dummy directories and files we will just use the
# root directory of this 'shell-playground' repository.
ROOT_DIR=$(cd .. && pwd)
echo "ROOT_DIR set to $ROOT_DIR"

# The bare fzf command will open the fzf selector and populate the list (asynchronously!) with all files in the current
# directory and all files contained recursively among those files. (I think it excludes hidden files).
function bareFzf() {
  fzf
}

# Use fzf to select from the list of non-hidden directories up to a depth of three
function fzfFromFind() {
  find "$ROOT_DIR" -not -path '*/\.*' -type d -maxdepth 3 | fzf
}

# Use fzf and find to select a directory from a list of directories and then change to that directory
function fzfChangeDirectory() {
  local DEST
  local EXIT_STATUS
  DEST=$(find "$ROOT_DIR" -type d | fzf)
  EXIT_STATUS=$?
  echo "Exit status of 'find | fzf' sub-shell: $EXIT_STATUS"
  if [[ $EXIT_STATUS -eq 0 ]]; then
    cd "$DEST"
  else
    echo >&2 "No directory was selected"
  fi
}

# Select an environment variable by exact match using fzf
function fzfEnv() {
  env | fzf --exact
}
