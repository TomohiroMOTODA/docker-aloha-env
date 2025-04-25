# ALOHA-DOCKER

このリポジトリは，Interbotix製ロボットアーム（XSシリーズ）をROS Noetic環境下で利用するためのDockerfileである．
DockerfileはOSRFが提供するros:noetic-desktop-fullイメージをベースに，
Interbotixの各種パッケージや依存ライブラリのインストールを自動化している．

## 📦 Overview

- ベース: osrf/ros:noetic-desktop-full
- Interbotix ROSパッケージ群の導入（interbotix_ros_core, interbotix_ros_manipulators, interbotix_ros_toolboxes）
  - Interbotixの公式インストールスクリプトを使用した前処理
  - Aloha プロジェクト: <https://www.trossenrobotics.com/> 
- modern_roboticsライブラリの導入
- GitHub SSH接続対応（git@github.com:形式）
- 任意の独自リポジトリ（例: aist-aloha）のクローン

## 🛠 Preliminaries

以下の環境が必要です:
- Docker（推奨: 最新版）
- docker buildおよび docker run の実行権限
- NVIDIA GPUを利用する場合: nvidia-container-toolkit の導入
- SSH鍵の転送を使う場合: ~/.ssh/id_rsa 等の適切なSSH設定
- Dockerのインストールは[こちら](./InstallDocker.md)を参照してください

## 🚀 Build Dockerfile

./ubuntu20-ros1-aloha
```bash
DOCKER_BUILDKIT=1 docker build -t aloha-ros1 .
```

./ubuntu20-ros1-cuda-aloha
```bash
DOCKER_BUILDKIT=1 docker build -t  aloha-cuda-ros1 .
```

## 🧪 Run Docker

```bash
docker run -it --rm --gpus all \
    --env="DISPLAY=$DISPLAY" \
    --env="NVIDIA_DRIVER_CAPABILITIES=all" \
    --env="NVIDIA_VISIBLE_DEVICES=all" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
     aloha-ros1 
```
🖥️ GUIを使用する場合、X11の設定が必要です（Linuxホスト想定）。xhost +local:等でX11のアクセス制御を緩和する必要があります。

🐚 事前にオプションが設定されたShellを利用することを推奨します。

```bash
chmod +x RUN_DOCKER_CONTAINER.sh
bash RUN_DOCKER_CONTAINER.sh
```
- 以下のソフトウェア・設定がホスト側に必要です：
  - Docker がインストール済みであること
  - X11 サーバが起動していること（Linux デスクトップ環境等）
  - aloha-ros1 イメージがビルド済みであること
  - DISPLAY 環境変数が正しく設定されていること
- 終了時には自動的にコンテナが削除されます（--rm）

## 📂 WS-Configuration

```bash
~/interbotix_ws
├── src
│   ├── interbotix_ros_core
│   ├── interbotix_ros_manipulators
│   ├── interbotix_ros_toolboxes
│   └── aloha  # ← aloha
├── devel
└── build
```

## 📓References

* <https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html>
* <https://gitlab.com/nvidia/container-images/cuda>
* <https://hub.docker.com/r/nvidia/cuda/tags?name=ubuntu20.04>
* <https://zenn.dev/kyoizmy/articles/333ffb5102e2cf>
* <https://qiita.com/enmaru/items/00b7a747fc682524cf2f>
* <https://qiita.com/takeru0208/items/3b4e24c291432a37ceda>
* <https://zenn.dev/3w36zj6/scraps/5a157d90398306>