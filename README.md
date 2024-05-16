# bash-playground

📚 Learning and exploring Bash and the shell in general; capturing useful snippets that I would otherwise too easily forget.


## Overview

This is a somewhat hap-hazard collection of command-line stuff, not just Bash. The project is split into the following
directories.


### `misc/`

Miscellaneous scripts and scratch content.

See the README in [misc/](misc/).


### `fzf/`

Learning and exploring `fzf` <https://github.com/junegunn/fzf> -- a command-line fuzzy finder.

See the README in [fzf/](fzf/).


### `perl/`

Learning and exploring Perl <https://www.perl.org/>.

See the README in [perl/](perl/).


### `completion/`

Learning and exploring Bash programmable completion.

See the README in [completion/](completion/).


## Wish List

General clean-ups, TODOs and things I wish to implement for this project:

* [ ] Add `xargs` examples
* [ ] Make an example with a fifo (a.k.a "named pipe")
* [x] DONE [Programmable completion](https://www.gnu.org/software/bash/manual/html_node/Programmable-Completion.html). Learn the very basics.
* [x] DONE [`bash-completion`](https://github.com/scop/bash-completion) examples. Learn the very basics and explore a real example like `docker`. I'm especially interested
  in how to invoke completions in a non-interactive way, like you would need for automated testing.
