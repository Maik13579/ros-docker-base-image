ARG ROS_DISTRO=humble
FROM ros:$ROS_DISTRO

#environment variables
ENV ROS_WS /root/ros2_ws
ENV DEBIAN_FRONTEND noninteractive

#ros2 middleware implementation
ENV RMW_IMPLEMENTATION=rmw_cyclonedds_cpp

#use bash
SHELL ["/bin/bash", "-c"]

#source ros stuff
COPY docker/ros2/ros_entrypoint.sh /ros_entrypoint.sh
ENTRYPOINT ["/ros_entrypoint.sh"]
RUN echo "source /ros_entrypoint.sh" >> /root/.bashrc

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
    ros-$ROS_DISTRO-rmw-cyclonedds-cpp \
    ros-$ROS_DISTRO-rviz2 \
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

#create workspace
WORKDIR $ROS_WS
RUN source /opt/ros/$ROS_DISTRO/setup.bash && \
    mkdir src && \
    colcon build --symlink-install && \
    echo "source $ROS_WS/install/setup.bash" >> /root/.bashrc

#fix rviz black screen https://github.com/ros2/rviz/issues/948
RUN apt update && apt install -y software-properties-common && add-apt-repository ppa:kisak/kisak-mesa && apt update && apt upgrade -y

#most important line
RUN echo "PS1='🐳  \[\033[1;36m\]\h \[\033[1;34m\]\W\[\033[0;35m\] \[\033[1;36m\]# \[\033[0m\]'" >> /root/.bashrc