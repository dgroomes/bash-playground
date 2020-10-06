#!/usr/bin/env bash
# Examples calling Perl from a Bash script.

replace() {
	echo "hello from bash!" | perl -ne 's/bash/perl/; print'
}
replace
