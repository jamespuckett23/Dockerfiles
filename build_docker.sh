#!/bin/bash

echo "Building Dockerfile"

dockerfile_path=~/workspace/Docker/humble-jammy/

docker build --file $dockerfile_path/base/Dockerfile --tag humble_base:latest .
