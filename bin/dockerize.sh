#!/bin/bash

root="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
path=${root}/../pkgs/docker-images

if [[ $# < 1 ]]; then
  echo "usage: ${0##*/} [image]"
  exit 1
fi

image=$1

cd $path/$image

echo "Building docker image..."
nix-build

echo "Loading docker image..."
docker -i result

# commands to publish an image:

# docker tag [image] [user]/[image]
# docker push [user]/[image]

cd -
