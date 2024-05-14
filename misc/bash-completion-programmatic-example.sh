#!/usr/bin/env -i /opt/homebrew/bin/bash --noprofile
#
# Calling 'bash-completion' completion functions programmatically (i.e. non-interactively).
#
# This script is a way for me to explore Bash's "programmable completions" feature and the 'bash-completion' library.
# In this script, we load the 'bash-completion' library and exercise completions for 'docker'. I have the
# 'bash-completion' library installed using HomeBrew, but you should be able to adapt this script to your own
# environment.
#
# Pay particular attention to the shebang line. We are trying to create a Bash process that's isolated from any other
# incidental setup that may have happened in the parent process (i.e. another Bash process) or from the ".bash_profile"
#
# The GNU Bash manual's section on "Programmable Completion" is recommended reading: https://www.gnu.org/software/bash/manual/html_node/Programmable-Completion.html

load-bash-completion-library() {
  # We want to disable the eager-style loading of completion scripts (v1 era), so we set the BASH_COMPLETION_COMPAT_DIR
  # environment variable to a non-existent directory. We also need to load the compatibility script. For much more
  # information, see the notes in 'BASH_COMPLETION.md' in https://github.com/dgroomes/my-config.
  export BASH_COMPLETION_COMPAT_DIR="/disable-legacy-bash-completions-by-pointing-to-a-dir-that-does-not-exist"

  if [[ ! -d "/opt/homebrew/Cellar/bash-completion@2" ]]; then
      echo >&2 "No bash-completion@2 installation found."
      exit 1
  fi

  versioned_installations=(/opt/homebrew/Cellar/bash-completion@2/*)
  if [ ${#versioned_installations[@]} -gt 1 ]; then
      echo >&2 "Multiple bash-completion@2 versions found in Homebrew directory. Please remove all but one. Completions will not be loaded."
  else
      . "${versioned_installations[0]}/share/bash-completion/bash_completion"
      . "${versioned_installations[0]}/etc/bash_completion.d/000_bash_completion_compat.bash"
  fi
}

# This is the interesting part. We simulate the completion environment variables and then call the completion function.
#
# COMP_LINE represents the current line of input. For example, "docker run --en"
# COMP_WORDS represents the words of the line. For example, ("docker" "run" "--en")
# COMP_POINT represents the index of the cursor when the completion is triggered
# COMP_CWORD represents the index of the word in COMP_WORDS where the cursor is
# COMPREPLY is the array that the completion function populates with completions
#
# For detailed information on these variables, see the GNU Bash manual's section on "Bash Variables": https://www.gnu.org/software/bash/manual/html_node/Bash-Variables.html
test_completion() {
    local line="$1"
    local expected_completions="$2"
    local actual_completions

    COMP_LINE="$line"
    IFS="$COMP_WORDBREAKS" read -a COMP_WORDS <<< "$COMP_LINE"
    COMP_POINT=${#COMP_LINE}

    # I think this is the number of words after the command. For example, if the completion is triggered when the line
    # is 'docker run --en', then this value is 2.
    COMP_CWORD=$(( ${#COMP_WORDS[@]} - 1 ))

    # Call the completion function
    # _comp_complete_load docker
    _docker

    # Convert the COMPREPLY array to a string for comparison
    actual_completions=$(IFS=$' '; echo "${COMPREPLY[*]}")

    if [[ "$actual_completions" == "$expected_completions" ]]; then
        echo "PASS: '$line'"
    else
        echo "FAIL: '$line'"
        echo "Expected: $expected_completions"
        echo "Actual:   $actual_completions"
    fi
}

load-bash-completion-library
# I don't know how the lazy loading is triggered. For now, I'm just going to load the 'ware' completion script manually.
. ~/.local/share/bash-completion/completions/docker

test_completion "docker c" "config container context commit cp create"
test_completion "docker run --en" "--entrypoint --env --env-file"
