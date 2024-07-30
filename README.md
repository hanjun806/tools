# tools

### centos
```
# 安装wget
yum -y install wget
wget -N https://raw.githubusercontent.com/hanjun806/tools/main/centos_init.sh && bash centos_init.sh

wget -N https://raw.githubusercontent.com/hanjun806/tools/main/read_user.sh && bash read_user.sh ssh_reader iBiumNGLHN36

sed -i '/^#PasswordAuthentication yes/s/^#//' /etc/ssh/sshd_config
echo "AllowUsers root ssh_reader" >> /etc/ssh/sshd_config
systemctl restart sshd.service

```
### rocky
```

# 安装wget
dnf -y install wget
wget -N https://raw.githubusercontent.com/hanjun806/tools/main/rocky_init.sh && bash rocky_init.sh

wget -N https://raw.githubusercontent.com/hanjun806/tools/main/read_user.sh && bash read_user.sh ssh_reader iBiumNGLHN36

sed -i '/^#PasswordAuthentication yes/s/^#//' /etc/ssh/sshd_config
echo "AllowUsers root ssh_reader" >> /etc/ssh/sshd_config
systemctl restart sshd.service

```