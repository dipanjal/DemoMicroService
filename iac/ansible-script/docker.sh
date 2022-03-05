sudo apt-get update && sudo apt-get upgrade -y
sudo apt install docker.io -y
sleep 10s
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker ${USER}
sudo curl -L https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
sleep 50s
sudo chmod +x /usr/local/bin/docker-compose



