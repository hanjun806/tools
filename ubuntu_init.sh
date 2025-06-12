#/bin/bash

sudo apt update
sudo apt install -y lrzsz
sudo apt install -y wget

# 安装docker
curl -fsSL https://get.docker.com | sh
systemctl enable docker.service
systemctl start docker
sudo docker --version


# 配置 UFW 防火墙
set -e

echo "🔧 开始配置 UFW 防火墙..."

# 开启 IP 转发
echo "🛠️ 开启 IPv4 转发..."
sudo sed -i 's/#net\/ipv4\/ip_forward=1/net\/ipv4\/ip_forward=1/' /etc/ufw/sysctl.conf

# 配置端口转发规则
echo "🔁 添加端口转发规则到 /etc/ufw/before.rules..."

sudo sed -i '/^*nat/,$d' /etc/ufw/before.rules 2>/dev/null || true

sudo tee -a /etc/ufw/before.rules > /dev/null << 'EOF'
*nat
:PREROUTING ACCEPT [0:0]
:POSTROUTING ACCEPT [0:0]
-A PREROUTING -p tcp --dport 40000:41000 -j REDIRECT --to-port 5001
-A PREROUTING -p tcp --dport 41000:42000 -j REDIRECT --to-port 5002
-A PREROUTING -p tcp --dport 42000:43000 -j REDIRECT --to-port 5011
-A PREROUTING -p tcp --dport 43000:44000 -j REDIRECT --to-port 5012
COMMIT
EOF

# 开放端口
echo "🌐 开放端口..."
sudo ufw allow 22/tcp
sudo ufw allow 34500:34599/tcp

# 添加 IP 白名单
echo "🧾 添加 IP 白名单..."
sudo ufw allow from 45.78.17.247
sudo ufw allow from 144.34.238.10
sudo ufw allow from 110.81.154.8
sudo ufw allow from 47.254.86.140
sudo ufw allow from 144.34.224.56
sudo ufw allow from 47.97.109.44


# 启用防火墙
echo "✅ 启用 UFW 防火墙..."
sudo ufw disable
sudo ufw enable

# 显示当前规则
echo "📋 当前防火墙状态:"
sudo ufw status numbered

echo "🎉 UFW 配置完成！"