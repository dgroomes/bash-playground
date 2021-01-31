#!/usr/bin/env bash
# Examples using date and time

# Current (rather, "now"!) date and time
now() {
	date
}
#now

# Current day (e.g. Monday, Tuesday, Wednesday, etc.)
nowDay() {
	date +%A
}
#nowDay

# Composite custom formatting
# Note: I can't find canonical docs on datetime format strings on macOS. For example the man pages for 'date' on macOS
# doesn't describe the 'Z' or 'A' options. Instead I've just been searching ad hoc online to figure out valid options.
nowCustomFormatting() {
	date "+Current date and time: %Y-%m-%d %H:%M %Z"
}
#nowCustomFormatting

# Current date and time in other timezones
nowAcrossTimeZones() {
	(export TZ="America/New_York"; echo "Time in '$TZ': "; date '+%t%+')
	(export TZ="America/Chicago"; echo "Time in '$TZ': "; date '+%t%+')
	(export TZ="America/Los_Angeles"; echo "Time in '$TZ': "; date '+%t%+')
}
nowAcrossTimeZones

