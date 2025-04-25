# How to install Docker on Ubuntu

[[Back](./README.md)]

## Prerequisites

1. Ensure your system is running a supported version of Ubuntu (e.g., 20.04 or later).
2. You need `sudo` privileges to install Docker.

## Installation Steps

1. **Update the package index:**
    ```bash
    sudo apt update
    ```

2. **Install required packages:**
    ```bash
    sudo apt install -y \
        ca-certificates \
        curl \
        gnupg \
        lsb-release
    ```

3. **Add Docker’s official GPG key:**
    ```bash
    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    ```

4. **Set up the Docker repository:**
    ```bash
    echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    ```

5. **Update the package index again:**
    ```bash
    sudo apt update
    ```

6. **Install Docker:**
    ```bash
    sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
    ```

7. **Verify Docker installation:**
    ```bash
    sudo docker --version
    ```

    sample: 
    ```bash
    Docker version 20.10.17, build 100c701
    ```

## Tutorial

```bash
sudo docker run hello-world

...

Hello from Docker!
This message shows that your installation appears to be working correctly.
```


## Post-Installation Steps

1. **Run Docker as a non-root user (optional):**
    ```bash
    sudo usermod -aG docker $USER
    ```
    Log out and back in for the changes to take effect.

2. **Test Docker:**
    ```bash
    sudo docker run hello-world
    ```

    If the output confirms Docker is running, the installation was successful.

## Uninstallation (if needed)

To remove Docker from your system:
```bash
sudo apt purge -y docker-ce docker-ce-cli containerd.io
sudo rm -rf /var/lib/docker
```

For more details, visit the [official Docker documentation](https://docs.docker.com/engine/install/ubuntu/).


## References

* <https://qiita.com/yoshiyasu1111/items/17d9d928ceebb1f1d26d>
* 