FROM ubuntu:22.04

# James Puckett <jcp0605@tamu.edu>
# Ubuntu 22.04 - jammy
# ROS 2 - humble

ARG DEBIAN_FRONTEND=noninteractive

ENV ROS_DISTRO=humble
ENV USER=rosdocker

# SHELL ["/bin/bash", "-xo", "pipefail", "-c"]

USER root

RUN apt update && apt install -y software-properties-common curl && \
    add-apt-repository universe && \
    curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | tee /etc/apt/sources.list.d/ros2.list > /dev/null

RUN apt update && apt upgrade -y && \
    DEBIAN_FRONTEND=noninteractive apt install -y ros-${ROS_DISTRO}-desktop && \
    rm -rf /etc/sudoers && \
    apt install -y \
    python3-rosdep \
    python3-vcstool \
    python3-colcon-common-extensions \
    python3-colcon-mixin && \
    touch /etc/sudoers && \
    echo "Defaults env_reset" >> /etc/sudoers && \
    echo "Defaults mail_badpass" >> /etc/sudoers && \
    echo "Defaults secure_path=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin" >> /etc/sudoers && \
    echo "root ALL=(ALL) ALL" >> /etc/sudoers && \
    echo "%admin ALL=(ALL) ALL" >> /etc/sudoers && \
    echo "%sudo ALL=(ALL:ALL) ALL" >> /etc/sudoers && \
    echo "rosdocker ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

RUN apt-get update \
    && apt upgrade -y \
    && apt install -y vim bash bash-completion git \
    && groupadd ros \
    && useradd -m -s /bin/bash -G sudo,ros,adm,dialout,dip,plugdev $USER \
    && echo "$USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

RUN apt-get update && apt-get upgrade --no-install-recommends -y && \
    apt-get install -y ros-dev-tools \
    python3-pip \
    wget \
    libboost-all-dev \
    libeigen3-dev \
    libflann-dev 

USER $USER

ENV WORKSPACE=/home/$USER
WORKDIR $WORKSPACE

RUN echo "source /opt/ros/humble/setup.bash" << .bashrc && \
    echo "source /home/$USER/CSCE635/devel/setup.bash" << .bashrc && \
    echo "source /home/$USER/CSCE752/devel/setup.bash" << .bashrc && \
    echo "source /home/$USER/MEEN689/devel/setup.bash" << .bashrc && \
    /bin/bash -c 'source .bashrc'