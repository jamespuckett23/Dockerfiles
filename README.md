# Included in the Dockerfile

# Setting up the Docker container

# Setting up visuals from the Docker Container
1. X11 forwarding
- --env DISPLAY=$DISPLAY
- arg
- volume
- However, Mac dockers use a VM to create the docker environment, but this does not give the docker containers access to the GPU (Intel)

2. Connecting to the localhost:8080 website
- https://github.com/novnc/noVNC -> setting up the noVNC webserver
- https://websitebeaver.com/set-up-localhost-on-macos-high-sierra-apache-mysql-and-php-7-with-sslhttps
- https://github.com/adeeb10abbas/ros2-docker-dev/tree/noetic -> set ROS/Docker up with webserver

