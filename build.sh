#!/usr/bin/env bash
# Fetch the latest version of the library
fetch() {
if [ -f "subprocess.h" ]; then return; fi
URL="https://github.com/sheredom/subprocess.h/raw/refs/heads/master/subprocess.h"
FILE="subprocess.h"

# Download the release
echo "Downloading $FILE from $URL ..."
curl -L "$URL" -o "$FILE"
echo ""
}


# Test the project
test() {
echo "Running 01-run-command.c ..."
clang -I. -o 01.exe examples/01-run-command.c         && ./01.exe && echo -e "\n"
echo "Running 02-pipe-communication.c ..."
clang -I. -o 02.exe examples/02-pipe-communication.c  && ./02.exe && echo -e "\n"
}


# Main script
if [[ "$1" == "test" ]]; then test
elif [[ "$1" == "fetch" ]]; then fetch
else echo "Usage: $0 {fetch|test}"; fi
