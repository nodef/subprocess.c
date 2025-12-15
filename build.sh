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
echo "Running 01-validate-utf8.c ..."
clang -I. -o 01.exe examples/01-validate-utf8.c  && ./01.exe && echo -e "\n"
echo "Running 02-utf8-length.c ..."
clang -I. -o 02.exe examples/02-utf8-length.c    && ./02.exe && echo -e "\n"
echo "Running 03-utf8-to-upper.c ..."
clang -I. -o 03.exe examples/03-utf8-to-upper.c  && ./03.exe && echo -e "\n"
}


# Main script
if [[ "$1" == "test" ]]; then test
elif [[ "$1" == "fetch" ]]; then fetch
else echo "Usage: $0 {fetch|test}"; fi
