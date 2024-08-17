# Calling 'bash-completion' completion functions programmatically (i.e. non-interactively).
#
# This script is a way for me to explore Bash's "programmable completions" feature and the 'bash-completion' library.
# In this script, we load the 'bash-completion' library and exercise completions for a custom command called
# 'describe-color'. I have the 'bash-completion' library installed using Homebrew, but you should be able to adapt
# this script to your own environment.
#
# Do NOT just execute this script with "bash bash-completion-example-non-interactive.bash". This script is designed to
# be run with extra isolation so that we don't accidentally inherit environment variables that will affect the behavior
# of the 'bash-completion' library. A reproducible environment is best for learning and experimentation. Run the script
# with the following command
#
#     env -i /opt/homebrew/bin/bash --noprofile bash-completion-example-non-interactive.bash
#
# By using "env -i", we isolate the new Bash subprocess from any other incidental environmental knowledge that was set
# in the parent process. For example, the subprocess will have no PATH, no HOME, and not much of anything. By using
# "--noprofile", we also avoid any setup that happens in the ".bash_profile".
#
# The GNU Bash manual's section on "Programmable Completion" is recommended reading: https://www.gnu.org/software/bash/manual/html_node/Programmable-Completion.html

if [[ ! -d "/opt/homebrew/opt/bash-completion@2" ]]; then
    echo >&2 "No bash-completion@2 installation found."
    exit 1
fi

# This makes it so that 'bash-completion' will find 'completions/_describe-color' in its "search order" when it is
# trying to load the completion script for 'describe-color'.
export BASH_COMPLETION_USER_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

. /opt/homebrew/opt/bash-completion@2/share/bash-completion/bash_completion
. /opt/homebrew/opt/bash-completion@2/etc/bash_completion.d/000_bash_completion_compat.bash

# Trigger 'bash-completion' to find and load the completion script for a command (e.g. 'describe-color' or '7z'). We
# happen to know that the completion function for 'describe-color' is defined in 'completions/_describe-color' and we
# could just source that directly, but we want the general approach. Let's trigger 'bash-completion' to do its thing
# and load the completion script as it would in a normal shell environment.
#
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
trigger_completion_function_registration_and_find_completion_function() {
		local command="$1"
		local comp_spec
		local -a comp_spec_array=()

		_comp_complete_load $command

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
    $completion_function $COMP_WORDS

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

trigger_completion_function_registration_and_find_completion_function describe-color
test_completion "describe-color " "red blue green"
test_completion "describe-color g" "green"
test_completion "describe-color gr" "green"

# Now let's try completions for 7z. The 'bash-completion' distribution comes with completion scripts for many standard
# command line tools like 7z, lsof, rsync, and more.
trigger_completion_function_registration_and_find_completion_function 7z
test_completion "7z " "a b d e h i l rn t u x"
