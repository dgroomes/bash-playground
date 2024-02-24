#!/usr/bin/env bash
#
# Use 'trap' to do things like clean up temporary files.
#
# This script executes the familiar pattern of creating a temporary file, doing some work, and then cleaning up the
# temporary file. By using a 'trap', we can ensure that the temporary file is always removed (mostly), even if the
# script has multiple exit points or if an unexpected error occur. This is a pretty neat feature of Bash.
#
# This script implements a random dice roll. It looks something like this:
#
# ./traps.sh
# You rolled a 3 and a 4.
# That's a lucky 7!

# Create a temporary file that describes the dice roll.
transcription=$(mktemp /tmp/mytempfile.XXXXXX)

if [[ ! -f $transcription ]]; then
		echo "Failed to create temporary file"
		exit 1
fi

play_transcription_and_clean_up() {
  cat "$transcription"
  rm "$transcription"
}

trap play_transcription_and_clean_up EXIT

# Simulate a dice roll.
die_roll_a=$((RANDOM % 5 + 1))
die_roll_b=$((RANDOM % 5 + 1))

echo "You rolled a $die_roll_a and a $die_roll_b." >> "$transcription"

if [[ $((die_roll_a + die_roll_b)) -eq 7 ]]; then
		echo "That's a lucky 7!" >> "$transcription"
		exit 0
fi

if [[ $die_roll_a -eq 1 && $die_roll_b -eq 1 ]]; then
		echo "Snake eyes, ouch!" >> "$transcription"
		exit 0
fi

if [[ $die_roll_a -eq $die_roll_b ]]; then
		echo "Doubles, neat!">> "$transcription"
		exit 0
fi

echo "You didn't roll anything special." >> "$transcription"
