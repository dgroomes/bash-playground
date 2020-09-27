#!/usr/bin/env bash
# Stamping out a template file with Bash. How can this be implemented? Answer: 'awk' to the rescue!

intro="This README file was stamped out from a template file using a Bash script and the 'awk' program!"

notes=$(cat << EOF
Here are some notes.
  * What are the different patterns for filling out (or, "stamping out") a template file from a Bash script? Is 'sed'
    the common solution? Answer: no 'sed' does not accommodate multiline arguments well. 'awk' can be used instead.
  * Is there another common trick or pattern for the "template" use-case?
EOF
)

awk '
  BEGIN {
    intro=ARGV[2]; ARGV[2]="";
    notes=ARGV[3]; ARGV[3]="";
  }

  {
    gsub(/%INTRO%/, intro);
    gsub(/%NOTES%/, notes);
  }1
' README.template.md "$intro" "$notes"

