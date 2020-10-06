#!/usr/bin/perl
# Replace part of a string.
use strict;
use warnings;

my $name = 'Joe';
my $msg = 'Hello name!';
$msg =~ s/name/$name/;

printf "%s\n", $msg;