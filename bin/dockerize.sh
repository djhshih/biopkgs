#!/bin/bash

set -eu

root="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
path=${root}/../pkgs/docker-images

if (( $# < 1 )); then
  echo "usage: ${0##*/} <image>"
  echo ""
  echo "Available images:"
  echo ""
  ls -1 $path
  exit 1
fi

image=$1

cd $path/$image

echo "Building docker image..."
nix-build

echo "Loading docker image..."
docker load -i result

# commands to publish an image:

# docker tag [image] [user]/[image]
# docker push [user]/[image]

cd -
