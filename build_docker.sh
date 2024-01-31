#!/bin/bash

echo "Building Dockerfile"

dockerfile_path=~/workspace/Docker/noetic-focal/

docker build --file $dockerfile_path/base/Dockerfile --tag noetic_base:latest .
