#!/usr/bin/env bash
#
# Can we test a programmable completion function in a non-interactive way?

# A completion function. This defines completion logic for a fictional command called 'describe_color'. The 'describe_color'
# is not actually implemented in this script because we're only testing the completion function.
_describe_color() {
   local cur opts
   COMPREPLY=()
   cur="${COMP_WORDS[COMP_CWORD]}"
   opts="red blue green"

   COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
}

test_completion() {
    local cur="$1"
    local expected_completions="$2"
    local actual_completions

    # Set up the completion environment variables
    COMP_WORDS=("describe_color" "$cur")
    COMP_CWORD=1
    COMPREPLY=()

    # Call the completion function
    _describe_color

    # Convert the COMPREPLY array to a string for comparison
    actual_completions=$(IFS=$' '; echo "${COMPREPLY[*]}")

    if [[ "$actual_completions" == "$expected_completions" ]]; then
        echo "PASS: completion '$cur'"
    else
        echo "FAIL: completion '$cur'"
        echo "Expected: $expected_completions"
        echo "Actual:   $actual_completions"
    fi
}

test_completion "" "red blue green"
test_completion "r" "red"
test_completion "b" "blue"
test_completion "g" "green"
test_completion "y" ""
