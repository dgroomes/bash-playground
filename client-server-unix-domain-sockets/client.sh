#!/usr/bin/env bash

socket_path="/tmp/my_server.sock"
fifo_path="/tmp/my_fifo"

# Create a named pipe (FIFO)
mkfifo "$fifo_path"

# Open a connection to the Unix domain socket in the background
nc -U "$socket_path" <"$fifo_path" &

# Send messages to the server
printf "Hello, server!\n" >"$fifo_path"
printf "This is the second message.\n" >"$fifo_path"

# Give nc some time to send the data. This is unfortunate. Not sure how to avoid it.
sleep .2

# Clean up and close the connection
rm -f "$fifo_path"
kill %1
