#!/usr/bin/env -i /opt/homebrew/bin/bash --noprofile
#
# Calling 'bash-completion' completion functions programmatically (i.e. non-interactively).
#
# This script is a way for me to explore Bash's "programmable completions" feature and the 'bash-completion' library.
# In this script, we load the 'bash-completion' library and exercise completions for a custom command called
# 'describe-color'. I have the 'bash-completion' library installed using HomeBrew, but you should be able to adapt
# this script to your own environment.
#
# Pay attention to the shebang line. We are trying to create a Bash process that's isolated from any other incidental
# setup that may have happened in the parent process (i.e. another Bash process) or from the ".bash_profile"
#
# The GNU Bash manual's section on "Programmable Completion" is recommended reading: https://www.gnu.org/software/bash/manual/html_node/Programmable-Completion.html

if [[ ! -d "/opt/homebrew/Cellar/bash-completion@2" ]]; then
    echo >&2 "No bash-completion@2 installation found."
    exit 1
fi

versioned_installations=(/opt/homebrew/Cellar/bash-completion@2/*)
if [ ${#versioned_installations[@]} -gt 1 ]; then
    echo >&2 "Multiple bash-completion@2 versions found in Homebrew directory. Please remove all but one. Completions will not be loaded."
    exit 1
fi

# This makes it so that 'bash-completion' will find 'completions/_describe-color' in its "lookup path" when it is
# trying to load the completion script for 'describe-color'.
export BASH_COMPLETION_USER_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

. "${versioned_installations[0]}/share/bash-completion/bash_completion"
. "${versioned_installations[0]}/etc/bash_completion.d/000_bash_completion_compat.bash"

# Trigger 'bash-completion' to find and load the completion script for 'describe-color'. We happen to know that the
# completion function is defined in 'completions/_describe-color' and we could just source that directly, but we want
# 'bash-completion' to do its thing and load the completion script as it would in a normal shell environment.
_comp_complete_load describe-color

# Similarly, we need to figure out the name of the completion function. If a completion function was successfully loaded,
# then we'll find it with 'complete -p describe-color'. This command outputs the original "comp spec" that was used to
# register the completion function in the first place. For example:
#
#    $ complete -p describe-color
#    complete -F _describe-color describe-color
#
#    $ complete -p openssl
#    complete -o default -F _comp_cmd_openssl openssl
#
find_completion_function() {
		local command="$1"
		local comp_spec
		local -a comp_spec_array=()

    comp_spec=$(complete -p "$command" 2>/dev/null)
		_comp_split comp_spec_array "$comp_spec" || return 1

		# Iterate over the words in the 'complete' string and find the completion function name
		local i=0
		for ((i=0; i<${#comp_spec_array[@]}; i++)); do
				if [[ "${comp_spec_array[$i]}" == "-F" ]] && (( i+1 < ${#comp_spec_array[@]} )); then
      		completion_function="${comp_spec_array[$((i + 1))]}"
      		return 0
				fi
		done

		return 1
}

find_completion_function describe-color || {
		echo "Could not find completion function for 'describe-color'"
		exit 1
}

# Save the completion function name so we can invoke it programmatically in the test function.
describe_color_completion_function="$completion_function"

# This is the interesting part. We simulate the completion environment variables and then call the completion function.
#
# COMP_LINE represents the current line of input. For example, "describe-color gre"
# COMP_WORDS represents the words of the line. For example, ("describe-color" "gre")
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
    _comp_split COMP_WORDS "$COMP_LINE" || return 1

    # In the frequent case that there are no words after the command (e.g. "describe-colors "), we have to simulate that
    # there is actually one word and it's the empty string.
    if [[ "${#COMP_WORDS[@]}" -eq 1 ]]; then
				COMP_WORDS+=("")
		fi
    COMP_POINT=${#COMP_LINE}

    # This is the number of words after the command. For example, if the completion is triggered when the line
    # is 'describe-color gre', then this value is just 1.
    COMP_CWORD=$(( ${#COMP_WORDS[@]} - 1 ))

    # Call the completion function
    $describe_color_completion_function

    # Convert the COMPREPLY array to a string for comparison
    actual_completions=$(IFS=$' '; echo "${COMPREPLY[*]}")

    if [[ "$actual_completions" == "$expected_completions" ]]; then
        echo "PASS: '$line' completed to '$actual_completions'"
    else
        echo "FAIL: '$line' did not complete as expected"
        echo "Expected: $expected_completions"
        echo "Actual:   $actual_completions"
    fi
}

test_completion "describe-color " "red blue green"
test_completion "describe-color g" "green"
test_completion "describe-color gr" "green"

