#/bin/bash

yum -y install lrzsz

# 安装docker
curl -fsSL https://get.docker.com | sh
systemctl enable docker.service
systemctl start docker

# 同步时间
yum install ntpdate -y
ntpdate -u time1.google.com

sudo yum update ca-certificates -y

systemctl restart docker

# 安装x-ui
mkdir -p /mnt/x-ui && cd /mnt/x-ui

docker run -itd --network=host \
-v $PWD/db/:/etc/x-ui/ \
-v /mnt/data/cert/:/root/cert/ \
--name x-ui --restart=unless-stopped \
enwaiax/x-ui:alpha-zh

# 打开防火墙，动态端口处理
sudo yum -y install firewalld
systemctl start firewalld

firewall-cmd --permanent --add-port=22/tcp
firewall-cmd --permanent --add-port=34500-34599/tcp
firewall-cmd --permanent --add-forward-port=port=40000-41000:proto=tcp:toport=5001
firewall-cmd --permanent --add-forward-port=port=41000-42000:proto=tcp:toport=5002
firewall-cmd --permanent --add-forward-port=port=42000-43000:proto=tcp:toport=5011
firewall-cmd --permanent --add-forward-port=port=43000-44000:proto=tcp:toport=5012
firewall-cmd --permanent --add-rich-rule='rule family="ipv4" source address="45.78.17.247" accept'
firewall-cmd --permanent --add-rich-rule='rule family="ipv4" source address="199.180.119.109" accept'
firewall-cmd --reload
firewall-cmd --list-all
systemctl restart firewalld
systemctl restart docker

