#!/bin/bash

user=$1
passwd=$2

# 创建用户并设置 shell
useradd -m -s /bin/bash "${user}"

# 设置密码
echo "${user}:${passwd}" | chpasswd

# 创建 bin 目录
mkdir -p /home/${user}/.bin

# 设置 .bash_profile
cat > /home/${user}/.bash_profile <<EOF
PATH=/home/${user}/.bin:\$PATH
export PATH
EOF

# 权限设置
chown root:root /home/${user}/.bash_profile
chmod 755 /home/${user}/.bash_profile

# 创建常用命令的软链接（去除 cd）
ln -s /usr/bin/wc /home/${user}/.bin/wc
ln -s /usr/bin/tail /home/${user}/.bin/tail
ln -s /bin/more /home/${user}/.bin/more
ln -s /bin/cat /home/${user}/.bin/cat
ln -s /bin/grep /home/${user}/.bin/grep
ln -s /usr/bin/find /home/${user}/.bin/find
ln -s /bin/pwd /home/${user}/.bin/pwd
ln -s /bin/ls /home/${user}/.bin/ls
ln -s /bin/less /home/${user}/.bin/less
ln -s /bin/tar /home/${user}/.bin/tar
ln -s /bin/echo /home/${user}/.bin/echo