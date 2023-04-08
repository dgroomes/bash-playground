# client-server-unix-domain-sockets.

This example shows how to use Unix domain sockets to communicate between processes, specifically using Bash scripts.

## Overview

The main takeaway for me is that, "You can really use Unix domain sockets directly from Bash, and you need to use a fifo
as an intermediary?". I couldn't figure out how to not use a fifo. See the code in `client.sh` in particular, for more
information and in particular notice the `sleep .2` line.

Note: this example is more about Unix domain sockets as it is about Bash, so maybe `bash-playground` is not the best
spot for this example code to live, but this is the best place I could think of for now.


## Instructions

Follow these instructions to run the example:

1. Start the server
   * ```sh
     ./server.sh
     ```
2. Run the client
   * In a separate terminal session, run the client with the following command.
   * ```bash
     ./client.sh
     ```
3. Observe the output
   * In the terminal session where you started the server, you should see that the server program received and echoed
     the client's messages. It should look something like the following.
   * ```text
     $ ./server.sh
     Listening for messages...
     Received message: Hello, server!
     Received message: This is the second message.
     ```
