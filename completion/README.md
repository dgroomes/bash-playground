# completion

Learning and exploring Bash programmable completion.


## Overview

Programmable completion has always been daunting to me. The scripts in this directory have let me incrementally
understand the topic by exploring interactive completion, non-interactive completion, and then finally the mechanisms
of the 'bash-completion' library. 

1. Start with the essentials
   * ```shell
     . programmable-completion-example.bash
     ```
   * Study the source code, exercise the completions, and experiment for yourself.
2. Graduate to *non-interactive* (i.e. headless, i.e. programmatic) completion
   * ```shell
     ./programmable-completion-example-non-interactive.bash
     ```
   * This script is interesting because it simulates a completion environment. This is useful for automated testing.
3. Graduate to 'bash-completion'
   * ```shell
     ./bash-completion-example-non-interactive.sh
     ```
   * This was pretty difficult. However, the 'bash-completion' source code is well documented and with the help of an
     LLM you have a chance to actually tease apart Bash code.


## Wish List

General clean-ups, TODOs and things I wish to implement for this project:

* [x] DONE Figure out how to autoload a completion script.
* [x] DONE Consider file renames for consistency
* [x] DONE Completions when no arguments. Am I not simulating the comp env vars correctly?
