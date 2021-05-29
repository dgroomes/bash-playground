#!/usr/bin/env perl
# Print the time including milliseconds.

use Time::HiRes qw(time);
use POSIX qw(strftime);

# Get the current time as a floating point scalar. Seconds from the epoch and fractional seconds. E.g. 1622307523.18013
my $now = time;

print $now, "\n";

# Expand the time scalar into an array of time components (hour, minute, second, etc)
my @timecomponents = localtime $now;

# Format the time components into a human-readable time string
my $timeformatted = strftime "%H:%M:%S", @timecomponents;

# Append milliseconds
$timeformatted .= sprintf ".%03d", ($now-int($now))*1000;

# Print the result!
print $timeformatted, "\n";
