#!/bin/bash

CONTAINER=noetic_base
VERSION=latest
NAME="ros_humble_courses"
USER="rosdocker"

# if ($1=='noetic'); then

# humble
# docker run -it \
#            --pid="" \
#            --network=host \
#            --name=$NAME \
#            -e DISPLAY \
#            -v /tmp/.X11-unix:/tmp/.X11-unix \
#            -v /Users/jamespuckett/.ssh:/home/$USER/.ssh \
#            -v /Users/jamespuckett/workspace/courses/CSCE752:/home/$USER/CSCE752 \
#            -v /Users/jamespuckett/workspace/courses/MEEN689:/home/$USER/MEEN689 \
#            $CONTAINER:$VERSION \
#            /bin/bash

# noetic
NAME="ros_noetic_courses"
docker run -it \
           -e DISPLAY=docker.for.mac.host.internal:0 \
           -v /tmp/.X11-unix:/tmp/.X11-unix \
           --env=QT_X11_NO_MITSHM=1 \
           -v ~/.Xauthority:/root/.Xauthority \
           -v /dev/:/dev/ \
           --pid="" \
           --network=host \
           --gpus all \
           --privileged \
           --interactive \
           --name=$NAME \
           -v /Users/jamespuckett/.ssh:/home/$USER/.ssh \
           -v /Users/jamespuckett/workspace/courses/MEEN689:/home/$USER/MEEN689 \
           $CONTAINER:$VERSION \
           /bin/bash