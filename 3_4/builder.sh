#!/bin/sh

if [ "$#" -ne 2 ]; then
  echo "Usage: ./builder.sh <github-repo> <docker-image>"
  exit 1
fi

set -e # stop at the first command that fails

TMP=$(mktemp -d) # 1. make a temporary folder and keep its path in a variable
trap 'rm -rf "$TMP"' EXIT

# Clone and push
git clone "https://github.com/$1" "$TMP"
cd "$TMP"
docker build -t "$2" .
echo "$DOCKER_PWD" | docker login -u "$DOCKER_USER" --password-stdin
docker push "$2"

