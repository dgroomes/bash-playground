#!/usr/bin/env bash
# heredoc examples
# https://tldp.org/LDP/abs/html/here-docs.html

cat << EOF
hello there
EOF

wc -l << EOF
hello
there
EOF
