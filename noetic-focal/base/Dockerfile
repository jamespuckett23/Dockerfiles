FROM ros:noetic-perception-focal

# James Puckett <jcp0605@tamu.edu>
# Ubuntu 20.04 - focal
# ROS 1 - noetic

ARG DEBIAN_FRONTEND=noninteractive
SHELL ["/bin/bash", "-c"]
ENV USER=rosdocker

USER root

# set up basic tools and environment
RUN apt-get update \
    && apt upgrade -y \
    && apt install -y vim bash bash-completion git \
    && groupadd ros \
    && useradd -m -s /bin/bash -G sudo,ros,adm,dialout,dip,plugdev $USER \
    && echo "$USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# install required packages
RUN apt-get update && apt-get upgrade --no-install-recommends -y && \
    apt-get install -y \
    python3-pip \
    wget \
    libboost-all-dev \
    libeigen3-dev \
    libflann-dev \
    curl

# install ROS
RUN apt update && apt upgrade -y && \
    DEBIAN_FRONTEND=noninteractive apt install -y ros-noetic-desktop && \
    apt update && apt install -y \
    python3-rosdep \
    python3-vcstool \
    python3-catkin-tools \
    ros-dev-tools \
    git

# install ROS/gazebo-classic packages
RUN curl -sSL http://get.gazebosim.org | sh && \
    apt install -y \
    ros-noetic-gazebo-ros-pkgs \
    ros-noetic-gazebo-ros-control && \
    apt update && apt upgrade -y

# set up workspace
USER $USER
ENV WORKSPACE=/home/$USER
WORKDIR $WORKSPACE

# set up ros course environment 
RUN mkdir /home/$USER/CSCE635/src/ -p && \
    cd /home/$USER/CSCE635 && \
    source /opt/ros/noetic/setup.bash && \
    catkin init && catkin build

RUN mkdir /home/$USER/pg_slam_ws/src/ -p && \
    cd /home/$USER/pg_slam_ws/src/ && \
    git clone https://github.com/husky/husky.git && \
    cd ~/pg_slam_ws/ && \
    rosdep update && \
    . /opt/ros/noetic/setup.bash && \
    catkin init && catkin build

USER root

# set up husky gazebo environment
RUN apt update && apt upgrade -y && \
    apt install -y ros-noetic-husky-simulator && \
    echo "export HUSKY_GAZEBO_DESCRIPTION=$(rospack find husky_gazebo)/urdf/description.gazebo.xacro" >> /home/$USER/.bashrc

USER $USER

# set up user interface
RUN echo "source /opt/ros/noetic/setup.bash" >> .bashrc && \
    echo "source /home/$USER/CSCE635/devel/setup.bash" >> .bashrc && \
    echo "PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@docker-noetic:\[\033[01;34m\]\w\[\033[00m\]\$ '" >> .bashrc && \
    . ~/.bashrc