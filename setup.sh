sudo apt-get update && sudo apt-get install -y apt-transport-https ca-certificates curl git-core software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable edge"
sudo apt-get update && sudo apt-get install -y docker-ce docker-compose
sudo curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-`uname -s`-`uname -m` -o /usr/bin/docker-compose

sudo git clone https://github.com/superphung/shadowsocks-obfs-docker.git
cd shadowsocks-obfs-docker
sudo docker build -t shadowsocks .
sudo docker images
sudo docker-compose up -d
sudo docker ps