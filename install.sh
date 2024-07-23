sudo apt update
sudo apt-get remove needrestart -y
sudo apt upgrade -y
sudo apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
    
sudo mkdir -m 0755 -p /etc/apt/keyrings

curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
| sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo "deb [arch=$(dpkg --print-architecture) \
signed-by=/etc/apt/keyrings/docker.gpg] \
https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
| sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update

sudo apt-get install -y \
docker-ce docker-ce-cli containerd.io \
docker-buildx-plugin docker-compose-plugin

# Run Docker in rootless mode
sudo sh -eux <<EOF
# Install newuidmap & newgidmap binaries
apt-get install -y uidmap
EOF

dockerd-rootless-setuptool.sh install

# Set Docker run automatically at startup
sudo loginctl enable-linger linuxadmin

# If you need to restart Docker you have use this Syntax
# systemctl --user (start|stop|restart) docker.service
