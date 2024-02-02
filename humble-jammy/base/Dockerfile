FROM ros:humble-perception-jammy

# James Puckett <jcp0605@tamu.edu>
# Ubuntu 22.04 - jammy
# ROS 2 - humble

ARG DEBIAN_FRONTEND=noninteractive
SHELL ["/bin/bash", "-c"]
ENV USER=rosdocker

USER root

RUN apt update && apt upgrade -y && \
    DEBIAN_FRONTEND=noninteractive apt install -y ros-humble-desktop && \
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

RUN echo "source /opt/ros/humble/setup.bash" >> .bashrc && \
    echo "source /home/$USER/CSCE752/devel/setup.bash" >> .bashrc && \
    echo "source /home/$USER/MEEN689/devel/setup.bash" >> .bashrc && \
    echo "PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@docker-humble\$ '" >> .bashrc && \
    . ~/.bashrc