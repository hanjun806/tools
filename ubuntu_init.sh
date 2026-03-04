#/bin/bash

sudo apt update
sudo apt install -y lrzsz
sudo apt install -y wget

# 安装docker
curl -fsSL https://get.docker.com | sh
systemctl enable docker.service
systemctl start docker
sudo docker --version

# 打开防火墙，动态端口处理
sudo ufw disable
sudo systemctl stop ufw
sudo systemctl disable ufw

sudo apt install firewalld -y
sudo systemctl enable firewalld
sudo systemctl start firewalld

firewall-cmd --permanent --add-port=22/tcp
firewall-cmd --permanent --add-port=34500-34599/tcp
firewall-cmd --permanent --add-forward-port=port=40000-41000:proto=tcp:toport=5001
firewall-cmd --permanent --add-forward-port=port=41000-42000:proto=tcp:toport=5002
firewall-cmd --permanent --add-forward-port=port=42000-43000:proto=tcp:toport=5011
firewall-cmd --permanent --add-forward-port=port=43000-44000:proto=tcp:toport=5012
firewall-cmd --permanent --add-rich-rule='rule family="ipv4" source address="45.78.17.247" accept'
firewall-cmd --permanent --add-rich-rule='rule family="ipv4" source address="144.34.238.10" accept'
firewall-cmd --permanent --add-rich-rule='rule family="ipv4" source address="47.254.86.140" accept'
firewall-cmd --permanent --add-rich-rule='rule family="ipv4" source address="47.97.109.44" accept'
firewall-cmd --permanent --add-rich-rule='rule family="ipv4" source address="144.34.238.10" accept'
firewall-cmd --permanent --add-rich-rule='rule family="ipv4" source address="47.251.7.102" accept'
firewall-cmd --permanent --add-rich-rule='rule family="ipv4" source address="144.34.224.56" accept'
firewall-cmd --permanent --add-rich-rule='rule family="ipv4" source address="118.31.113.108" accept'
firewall-cmd --permanent --add-rich-rule='rule family="ipv4" source address="47.253.216.147" accept'
firewall-cmd --permanent --add-rich-rule='rule family="ipv4" source address="47.254.34.252" accept'
firewall-cmd --reload
firewall-cmd --list-all
systemctl restart firewalld
systemctl restart docker
