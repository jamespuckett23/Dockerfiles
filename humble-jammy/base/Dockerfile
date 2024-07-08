FROM ubuntu:22.04

# James Puckett <jcp0605@tamu.edu>
# Ubuntu 22.04 - jammy
# ROS 2 - humble

ARG DEBIAN_FRONTEND=noninteractive
SHELL ["/bin/bash", "-c"]
ENV USER=rosdocker

USER root

# Install required packages
RUN apt update && apt upgrade --no-install-recommends -y && \
    apt install -y \
    python3-pip \
    wget \
    libboost-all-dev \
    libeigen3-dev \
    libflann-dev

RUN apt install -y software-properties-common && \
    add-apt-repository universe

RUN apt update && apt install curl -y && \
    curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | tee /etc/apt/sources.list.d/ros2.list > /dev/null

RUN apt update && apt upgrade && apt install -y ros-humble-desktop
    

# set up basic tools and environment
RUN apt update \
    && apt upgrade -y \
    && apt install -y vim bash bash-completion git apt-utils sudo \
    && groupadd ros \
    && useradd -m -s /bin/bash -G sudo,ros,adm,dialout,dip,plugdev $USER \
    && echo "$USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers


# RUN apt clean \
#     && apt update \
#     && apt install -y --no-install-recommends \
#     dbus-x11 \
#     shared-mime-info || echo "Ignoring shared-mime-info errors"


# # Install dbus-x11 separately
# RUN apt install -y --no-install-recommends dbus-x11

# RUN apt install -y dbus \ 
#     shared-mime-info \ 
#     dbus-x11

# RUN apt clean && rm -rf /var/lib/apt/lists/* /tmp/* \
#     && apt update && apt upgrade && \
#     apt-get reinstall -y libglib2.0-0 libxml2 shared-mime-info


# RUN apt-get install -y --reinstall libdbus-1-3 libglib2.0-0

# # Ensure proper configuration of packages
# RUN dpkg --configure -a

# Install ROS desktop
# RUN apt-get update && apt-get install -y --no-install-recommends \
#     ros-humble-desktop=0.10.0-1*

# # Clean up
# RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/*

# # Install dbus-x11 and handle shared-mime-info separately
# RUN apt-get install -y --no-install-recommends dbus-x11 \
#     && apt-get install -y --no-install-recommends shared-mime-info

# # Install ROS dependencies manually
# RUN apt-get download libqt5core5a libqt5positioning5 && \
#     dpkg -i libqt5core5a*.deb libqt5positioning5*.deb || apt-get install -f -y

# install ROS
# RUN apt-get update && apt-get install -y --no-install-recommends \
#     ros-humble-desktop=0.10.0-1*
    # && rm -rf /var/lib/apt/lists/*

# RUN apt-get update && apt-get upgrade -y && apt-get install -y sudo

RUN apt-get update && apt-get install -y \
    ros-dev-tools \
    python3-rosdep \
    python3-vcstool \
    python3-colcon-common-extensions \
    python3-colcon-mixin && \
    rm -rf /var/lib/apt/lists/*

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
    vcs import src < dependencies.repos

USER root
RUN cd /home/${USER}/slam && rosdep init

USER ${USER}
RUN cd ~/slam/ && \
    rosdep update && \
    rosdep install -r --from-paths src -i -y

RUN cd ~/slam/src/
    # git clone git@github.com:jamespuckett23/g2o_slam.git

RUN mkdir ~/BCDC/src/ -p
RUN mkdir ~/rl_ws/src/ -p

USER $USER
ENV WORKSPACE=/home/$USER
WORKDIR $WORKSPACE


RUN echo "source /opt/ros/humble/setup.bash" >> .bashrc && \
    echo "source /home/$USER/CSCE752/devel/setup.bash" >> .bashrc && \
    echo "source /home/$USER/MEEN689/devel/setup.bash" >> .bashrc && \
    echo "PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@docker-humble:\[\033[01;34m\]\w\[\033[00m\]\$ '" >> .bashrc && \
    . ~/.bashrc