#!/usr/bin/env bash
# Examples calling Perl from a Bash script.

replace() {
	echo "hello from bash!" | perl -ne 's/bash/perl/; print'
}
#replace

# Generate a large sample of JSON-formatted data for testing purposes.
# This is much faster than using a bash for loop.
generateTestData() {
	perl -f <(cat <<'EOF'
	  $json_template = '{ "x": %d, "y": %d }';
	  $lines = 3;

		for ($i = 1; $i <= $lines; $i++) {
		  $x = $i;
      $y = $lines - $i;

      printf $json_template, $i, $y;
      printf "\n"
    }
EOF
)
}
generateTestData

