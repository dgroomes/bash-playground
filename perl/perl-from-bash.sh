#!/usr/bin/env bash
# Examples calling Perl from a Bash script.

replace() {
	echo "hello from bash!" | perl -ne 's/bash/perl/; print'
}
#replace

# Generate a large sample of JSON-formatted data for testing purposes.
# This is much faster than using a bash for loop.
generateTestData() {

	export NUMBER_OF_LINES=3
	perl -f <(cat <<'EOF'
	  $json_template = '{ "x": %d, "y": %d }';
	  $number_of_lines = $ENV{NUMBER_OF_LINES};

		for ($i = 1; $i <= $number_of_lines; $i++) {
		  $x = $i;
      $y = $number_of_lines - $i;

      printf $json_template . "\n", $x, $y;
    }
EOF
)
}
generateTestData

