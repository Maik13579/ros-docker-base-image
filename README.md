# ROS-DOCKER-BASE-IMAGE
A docker image for ros.

## Build
Image name will be `ros-base-image` and the tag is the ros distro.

Example: `ros-base-image:noetic`

### build all
```bash
docker-compose -f docker/build.yml build
```

### ROS Noetic
```bash
docker-compose -f docker/build.yml build ros
```

### ROS2 Humble
```bash
docker-compose -f docker/build.yml build ros2
```

## Commands for .bashrc
A few commands to put in your ~/.bashrc file

```bash
export ROS_IP=127.0.0.1
export ROS_HOSTNAME=127.0.0.1
export ROS_MASTER_URI=http://127.0.0.1:11311

export ROS_DOMAIN_ID=11

ros(){
	CURRENT_DIR=$(pwd)
    docker run --rm -it \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -e DISPLAY \
    -e ROS_MASTER_URI\
    -e ROS_IP\
    -e ROS_HOSTNAME\
    --net=host \
    -v ${CURRENT_DIR}:${CURRENT_DIR} \
    ros-base-image:noetic \
    bash -c \
        "echo 'source /opt/ros/noetic/setup.bash' >> /root/.bashrc &&\
        cd ${CURRENT_DIR}
        bash\
        "
}

roscore(){
    docker run --rm -it \
    --name roscore \
    --net=host \
    -e ROS_MASTER_URI\
    -e ROS_IP\
    -e ROS_HOSTNAME\
    ros-base-image:noetic \
    roscore
}

ros2(){
	CURRENT_DIR=$(pwd)
	if [ -n "$1" ]; then
		export ROS_DOMAIN_ID=$1
	fi

    docker run --rm -it \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v /dev/shm:/dev/shm \
    -e DISPLAY \
    -e ROS_DOMAIN_ID\
    --net=host \
    -v ${CURRENT_DIR}:${CURRENT_DIR} \
    ros-base-image:humble \
    bash -c \
        "echo 'source /opt/ros/humble/setup.bash' >> /root/.bashrc &&\
        cd ${CURRENT_DIR}
        bash\
        "
}

rviz(){
    docker run --rm -it \
	--name rviz \
 	--net=host \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	-e DISPLAY \
    -e ROS_MASTER_URI \
    -e ROS_IP \
    -e ROS_HOSTNAME \
    ros-base-image:noetic \
    rviz
}

rviz2(){
	if [ -n "$1" ]; then
		export ROS_DOMAIN_ID=$1
	fi
    docker run --rm -it \
	--name rviz2 \
 	--net=host \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	-v /dev/shm:/dev/shm \
	-e DISPLAY \
	-e ROS_DOMAIN_ID \
    ros-base-image:humble \
    rviz2
}

```