# A simple example of Bash's "programmable completion" feature.
#
# We love auto-completion in our shells, code editors, and search engines. In Bash, auto-completion is implemented by
# what is called the "programmable completion" APIs.
#
# In this example, we'll create an example Bash function (or what we think of as a "command" in the shell) and a
# matching Bash completion function.
#
# Follow these instructions to try it out:
#
#   1. Source this script: source programmable-completion-example.bash
#   2. Type 'describe_color ' and press tab to see the available completions
#   3. Type 'describe_color g' and press tab to auto-complete the color 'green'
#   4. Press enter. That's it! As a user, you were able to conveniently discover the API of the 'describe_color' command
#      interactively.
#
# Bash's programmable completion feature isn't the whole story. Most Bash completion scripts are written with a
# third-party module called 'bash-completion'. The 'bash-completion' project is not part of the Bash project.

describe_color() {
   case "$1" in
       red)
           echo "Red is a passionate color."
           ;;
       blue)
           echo "Blue is a calming color."
           ;;
       green)
           echo "Green is a natural color."
           ;;
       *)
           echo "Please provide a valid color name as an argument."
           echo "Available colors: red, blue, green"
           ;;
   esac
}

# A completion function for the 'describe_color' command. By convention, the completion function has the same name as
# the "target" command but with an underscore prefix.
_describe_color() {
   local cur opts
   COMPREPLY=()
   cur="${COMP_WORDS[COMP_CWORD]}"
   opts="red blue green"

   # The 'compgen' command narrows the full list of completion options to those that match the current word. So, "r"
   # would narrow it down to an array of just "red".
   COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
}

# Register the completion function
complete -F _describe_color describe_color
