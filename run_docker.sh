#!/bin/bash

CONTAINER=humble_base
VERSION=latest
NAME="ros_humble_courses"
USER="rosdocker"

docker run -it \
           --pid="" \
           --network=host \
           --name=$NAME \
           -v /Users/jamespuckett/.ssh:/home/$USER/.ssh \
           -v /Users/jamespuckett/workspace/courses/CSCE635:/home/$USER/CSCE635 \
           -v /Users/jamespuckett/workspace/courses/CSCE752:/home/$USER/CSCE752 \
           -v /Users/jamespuckett/workspace/courses/MEEN689:/home/$USER/MEEN689 \
           $CONTAINER:$VERSION \
           /bin/bash

           #    -v ~/workspace/Dockerfiles:/Dockerfiles \