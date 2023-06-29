#!/bin/bash
#set -e
# setup ros environment
source "$ROS_WS/devel/setup.bash"

# to ensure that the roscore conatiner will be used for roscore
if [ -z ${WAIT_FOR_ROSCORE+0} ]
then
  echo "WAIT_FOR_ROSCORE variable not set -> program processing continues";
else
  if [ ${WAIT_FOR_ROSCORE} -eq 1 ]
  then
    echo "WAIT_FOR_ROSCORE == 1 -> waiting for roscore being started.."
    while ! rostopic list > /dev/null; do
	sleep 1
    done
    echo "roscore ready"
  fi
fi

exec "$@"
