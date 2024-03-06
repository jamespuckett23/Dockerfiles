FROM ros:humble-ros-base-jammy

# James Puckett <jcp0605@tamu.edu>
# Ubuntu 22.04 - jammy
# ROS 2 - humble

ARG DEBIAN_FRONTEND=noninteractive
SHELL ["/bin/bash", "-c"]
ENV USER=rosdocker

USER root

# set up basic tools and environment
RUN apt update \
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
RUN apt-get update && apt-get install -y --no-install-recommends \
    ros-humble-desktop=0.10.0-1* \
    && rm -rf /var/lib/apt/lists/*

RUN apt update && apt install -y \
    ros-dev-tools \
    python3-rosdep \
    python3-vcstool \
    python3-colcon-common-extensions \
    python3-colcon-mixin

# set up workspace
USER $USER
ENV WORKSPACE=/home/$USER
WORKDIR $WORKSPACE

# set up ros course environment 
RUN mkdir /home/$USER/CSCE752/src/ -p && \
    cd /home/$USER/CSCE752
    # source /opt/ros/humble/setup.bash
    # colcon build

RUN mkdir /home/$USER/MEEN689/src/ -p && \
    cd /home/$USER/MEEN689
    # source /opt/ros/humble/setup.bash
    # colcon build

USER root

# Add husky sim
# RUN apt update && \
#     wget https://packages.osrfoundation.org/gazebo.gpg -O /usr/share/keyrings/pkgs-osrf-archive-keyring.gpg && \
#     echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/pkgs-osrf-archive-keyring.gpg] http://packages.osrfoundation.org/gazebo/ubuntu-stable $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/gazebo-stable.list > /dev/null && \
#     apt-get update && \
#     apt-get install ignition-fortress ros-humble-clearpath-simulator -y

USER $USER
RUN mkdir ~/slam/src -p && \
    cd ~/slam && \
    wget https://raw.githubusercontent.com/clearpathrobotics/clearpath_simulator/main/dependencies.repos && \
    vcs import src < dependencies.repos && \
    rosdep update && \
    rosdep install -r --from-paths src -i -y



USER $USER
ENV WORKSPACE=/home/$USER
WORKDIR $WORKSPACE


RUN echo "source /opt/ros/humble/setup.bash" >> .bashrc && \
    echo "source /home/$USER/CSCE752/devel/setup.bash" >> .bashrc && \
    echo "source /home/$USER/MEEN689/devel/setup.bash" >> .bashrc && \
    echo "PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@docker-humble:\[\033[01;34m\]\w\[\033[00m\]\$ '" >> .bashrc && \
    . ~/.bashrc