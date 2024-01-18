FROM ros:humble

# install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
  vim \ 
  && rm -rf /var/lib/apt/lists/*

# source the ros2 environment everytime you open a bash terminal
RUN echo "source /opt/ros/${ROS_DISTRO}/setup.bash" >> /root/.bashrc
RUN echo "source /root/colcon_ws/install/setup.bash" >> /root/.bashrc

WORKDIR /root/colcon_ws
