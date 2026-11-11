Start the Sloperator playground server.

Use port `$ARGUMENTS`, defaulting to `8080` when no port is provided. Keep the port as a separate argument; do not interpolate it into a shell command or shell-injection block.

Current listening TCP processes:
!`lsof -nP -iTCP -sTCP:LISTEN`

Check the listening-process output for an existing Sloperator playground server on the selected port. If one is already running, report that and do not start another. Otherwise, start `uv run playground/server.py <port>` in the background using the selected port, then report how to access it.
