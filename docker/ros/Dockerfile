ARG ROS_DISTRO=noetic
FROM ros:$ROS_DISTRO

#environment variables
ENV ROS_WS /root/catkin_ws
ENV DEBIAN_FRONTEND noninteractive
ENV WAIT_FOR_ROSCORE 1

#use bash
SHELL ["/bin/bash", "-c"]

#source ros stuff
COPY docker/ros/ros_entrypoint.sh /ros_entrypoint.sh
ENTRYPOINT ["/ros_entrypoint.sh"]

#update packages
RUN apt update \
 && apt upgrade -y \
 && rm -rf /var/lib/apt/lists/*

#install important stuff
RUN apt update \
 && apt install -y \
    git \
    ssh \
    ros-$ROS_DISTRO-rqt-tf-tree \
    ros-$ROS_DISTRO-rqt-reconfigure \
    ros-$ROS_DISTRO-rqt-common-plugins \
    ros-$ROS_DISTRO-rviz \
    lsb-release \
    wget \
    curl \
    gnupg \
    vim \
    terminator \
    build-essential \
    python3-colcon-common-extensions \
    python3-rosdep \
    python3-pip \
 && rm -rf /var/lib/apt/lists/*

# create catkin_ws
WORKDIR $ROS_WS
RUN source /opt/ros/$ROS_DISTRO/setup.bash && \
    mkdir src && \
    cd src && \
    catkin_init_workspace && \
    cd .. && \
    catkin_make && \
    echo "source $ROS_WS/devel/setup.bash" >> /root/.bashrc

#most important line
RUN echo "PS1='🐳  \[\033[1;36m\]\h \[\033[1;34m\]\W\[\033[0;35m\] \[\033[1;36m\]# \[\033[0m\]'" >> /root/.bashrc