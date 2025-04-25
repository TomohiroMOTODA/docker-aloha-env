# syntax=docker/dockerfile:1

# Taken by <https://qiita.com/Yuya-Shimizu/items/3d9fc18f42aee40f23b3>

# osrfが提供するrosイメージ（タグがnoetic-desktop-full）をベースとしてダウンロード
FROM osrf/ros:noetic-desktop-full

# Docker実行してシェルに入ったときの初期ディレクトリ（ワークディレクトリ）の設定
WORKDIR /root/

# nvidia-container-runtime（描画するための環境変数の設定）
ENV NVIDIA_VISIBLE_DEVICES \
    ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES \
    ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics


RUN apt-get update && apt-get install curl git -y
RUN curl 'https://raw.githubusercontent.com/Interbotix/interbotix_ros_manipulators/main/interbotix_ros_xsarms/install/amd64/xsarm_amd64_install.sh' > xsarm_amd64_install.sh
RUN chmod +x xsarm_amd64_install.sh
RUN bash ./xsarm_amd64_install.sh -d noetic

RUN cd && mkdir interbotix_ws && \
    cd interbotix_ws && \
    mkdir src && \
    cd src

# Install necessary core packages
RUN apt-get update && apt-get install -yq emacs python3-pip byobu && \
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

# RUN cd interbotix_ws/src/interbotix_ros_core/interbotix_ros_xseries/interbotix_xs_sdk && \ 
#      cp 99-interbotix-udev.rules /etc/udev/rules.d/
# RUN udevadm control --reload-rules && udevadm trigger
RUN echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc

RUN cd interbotix_ws && /bin/bash -c "source /opt/ros/noetic/setup.bash; catkin_make"
RUN echo "source interbotix_ws/devel/setup.bash" >> ~/.bashrc

# GitHubにSSH接続するための設定
# RUN mkdir -p -m 0700 ~/.ssh && \
#     ssh-keyscan github.com >> ~/.ssh/known_hosts && \
#     git config --global url.git@github.com:.insteadOf https://github.com/

RUN cd && cd interbotix_ws/src &&  git clone https://github.com/tonyzhaozh/aloha.git

RUN rm xsarm_amd64_install.sh

# RUN byobu new -s "aloha"
# RUN byobu new-window -d -s "aloha" "ls -la && sleep 5"
