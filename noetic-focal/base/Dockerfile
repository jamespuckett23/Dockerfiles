FROM osrf/ros:noetic-desktop-full

# James Puckett <jcp0605@tamu.edu>
# Ubuntu 20.04 - focal
# ROS 1 - noetic

ARG DEBIAN_FRONTEND=noninteractive

ENV ROS_DISTRO=noetic
ENV USER=rosdocker
# ENV NVIDIA_VISIBLE_DEVICES \
#     ${NVIDIA_VISIBLE_DEVICES:-all}
# ENV NVIDIA_DRIVER_CAPABILITIES \
#     ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics

# SHELL ["/bin/bash", "-xo", "pipefail", "-c"]

USER root

RUN apt update && apt install -y software-properties-common curl && \
    add-apt-repository universe && \
    sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list' && \
    curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add -

RUN apt-get update && \
    apt-get install -y mesa-utils

# install nvidia driver
RUN apt-get install -y binutils
ADD NVIDIA-DRIVER.run /tmp/NVIDIA-DRIVER.run
RUN sh /tmp/NVIDIA-DRIVER.run -a -N --ui=none --no-kernel-module && \
    rm /tmp/NVIDIA-DRIVER.run

# install ROS
RUN apt update && apt upgrade -y && \
    DEBIAN_FRONTEND=noninteractive apt install -y ros-${ROS_DISTRO}-desktop && \
    apt update && apt install -y \
    python3-rosdep \
    python3-vcstool

# set up basic tools and environment
RUN apt-get update \
    && apt upgrade -y \
    && apt install -y vim bash bash-completion git \
    && groupadd ros \
    && useradd -m -s /bin/bash -G sudo,ros,adm,dialout,dip,plugdev $USER \
    && echo "$USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# install required packages
RUN apt-get update && apt-get upgrade --no-install-recommends -y && \
    apt-get install -y ros-dev-tools \
    python3-pip \
    wget \
    libboost-all-dev \
    libeigen3-dev \
    libflann-dev 

# set up workspace
USER $USER
ENV WORKSPACE=/home/$USER
WORKDIR $WORKSPACE

# set up user interface
RUN echo "source /opt/ros/noetic/setup.bash" << .bashrc && \
    echo "source /home/$USER/CSCE635/devel/setup.bash" << .bashrc && \
    /bin/bash -c 'source .bashrc'