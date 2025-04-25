FROM nvidia/cuda:12.8.1-cudnn-devel-ubuntu20.04
# FROM cld1994/cuda:10.1-cudnn7-devel-ubuntu20.04

WORKDIR /root/

ENV DEBIAN_FRONTEND=noninteractive

# Upgrade Packages
RUN apt-get update -q \
    && apt-get upgrade -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Utility packages
RUN apt-get update -q \
    && apt-get install -y software-properties-common \
    && add-apt-repository universe && apt-get update -q \
    && apt-get install -y git usbutils build-essential wget curl emacs byobu gedit sudo lsb-release locales \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install X11 requirements
RUN apt-get update -q && apt-get install -y \
    iputils-ping telnet x11-apps \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install Python
RUN apt-get update -q && apt-get install -y \
    python3.8 python3-pip python3-dev python3-tk python-is-python3 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install ROS
ENV ROS_DISTRO noetic
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu focal main" > /etc/apt/sources.list.d/ros-latest.list'
RUN curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -
RUN apt-get update -q \
    && apt-get install -y ros-noetic-desktop-full \
    && apt-get install -y python3-rosdep python3-rosinstall python3-rosinstall-generator python3-wstool build-essential python3-catkin-tools \
    && rosdep init \
    && rosdep update \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Setting for Japanese
RUN apt-get update -q && apt-get install -y \
    tzdata locales fonts-noto-cjk fcitx-mozc \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
RUN ln -s -f /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \
    dpkg-reconfigure tzdata && \
    locale-gen ja_JP.UTF-8

# Set user
ARG UID=1002
RUN useradd -m -u ${UID} ros

RUN sh -c 'echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc'
RUN sh -c 'echo "export ROS_HOSTNAME=localhost" >> ~/.bashrc'
RUN sh -c 'echo "export ROS_MASTER_URI=http://localhost:11311" >> ~/.bashrc'
RUN sh -c 'echo "export PYTHONPATH=/usr/local/lib/python3.8/dist-packages:$PYTHONPATH" >> ~/.bashrc'

## Install Interbotix Arm
RUN curl 'https://raw.githubusercontent.com/Interbotix/interbotix_ros_manipulators/main/interbotix_ros_xsarms/install/amd64/xsarm_amd64_install.sh' > xsarm_amd64_install.sh
RUN chmod +x xsarm_amd64_install.sh
RUN bash ./xsarm_amd64_install.sh -d noetic
RUN cd && mkdir interbotix_ws && \
    cd interbotix_ws && \
    mkdir src && \
    cd src

# Install necessary core packages
RUN apt-get update && apt-get install -yq python3-pip byobu emacs && \
    python3 -m pip install modern_robotics

# Install Interbotix Arm ROS packages
RUN cd interbotix_ws/src && \
    git clone -b noetic https://github.com/Interbotix/interbotix_ros_core.git && \
    git clone -b noetic https://github.com/Interbotix/interbotix_ros_manipulators.git && \
    git clone -b noetic https://github.com/Interbotix/interbotix_ros_toolboxes.git && \
    rm interbotix_ros_core/interbotix_ros_xseries/CATKIN_IGNORE && \
    rm interbotix_ros_manipulators/interbotix_ros_xsarms/CATKIN_IGNORE && \
    rm interbotix_ros_toolboxes/interbotix_xs_toolbox/CATKIN_IGNORE && \
    rm interbotix_ros_toolboxes/interbotix_common_toolbox/interbotix_moveit_interface/CATKIN_IGNORE
RUN cd interbotix_ws && \
    rosdep install --from-paths src --ignore-src -r -y


RUN echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc
RUN cd interbotix_ws && /bin/bash -c "source /opt/ros/noetic/setup.bash; catkin_make"
RUN echo "source interbotix_ws/devel/setup.bash" >> ~/.bashrc


# Install ALOHA official packag
RUN cd && cd interbotix_ws/src &&  git clone https://github.com/tonyzhaozh/aloha.git

RUN rm xsarm_amd64_install.sh

## Seup ALOHA environments
RUN apt install -y ros-noetic-usb-cam && apt install -y ros-noetic-cv-bridge
RUN pip install torchvision
RUN pip install torch
RUN pip install pyquaternion
RUN pip install pyyaml
RUN pip install rospkg
RUN pip install pexpect
RUN pip install mujoco==2.3.7
RUN pip install dm_control==1.0.14
RUN pip install opencv-python
RUN pip install matplotlib
RUN pip install einops
RUN pip install packaging
RUN pip install h5py

# Load ROS and ALOHA environments
RUN /bin/bash -c "source /opt/ros/noetic/setup.sh && source ~/interbotix_ws/devel/setup.sh"