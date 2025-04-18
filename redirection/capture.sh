#!/usr/bin/env bash
#
# Run a command and capture all input and output into files.
#
# This is a demo of redirection using facilities of the shell (but also some Bash-isms?). I always get confused about
# the syntax of redirection. When do I need an ampersand? What side do the '<' and '>' go on?
#
# The use case is relatable: you have an existing command that takes in data and outputs data, and you want a copy of
# this data so that you can debug it after-the-fact but without disrupting its normal inflow and outflow. With a script
# like this, you can retrofit the existing command by wrapping it in this script.
#
# Try it out with something like this:
#
#    echo "hello there" | ./capture.sh ./char-count.sh
#

if [ ! -t 0 ]; then
  # This expression is kind of nuts. I can't really explain it, but I kind of get it. Try to explain it.
  #
  # Note: It's important to have first checked if input is attached. If you use tee without input then it will complain
  # with "tee: read: Input/output error".
  exec 0< <(tee in.log)
fi

exec 1> >(tee out.log)
exec 2> >(tee err.log >&2)

# Replace the shell process image with the command we actually want to run. The file redirections stay in place because
# they are inherited by the new process.
exec "$@"
