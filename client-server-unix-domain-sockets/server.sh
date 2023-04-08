#!/usr/bin/env bash

socket_path="/tmp/my_server.sock"

# Clean up the socket file if it already exists
if [ -e "$socket_path" ]; then
    rm -f "$socket_path"
fi

echo "Listening for messages..."

# Create a Unix domain socket and bind it to the socket_path
nc -lkU "$socket_path" | while read -r message; do
    echo "Received message: $message"
done

# Clean up the socket file when the server is terminated
trap 'rm "$socket_path"' EXIT
