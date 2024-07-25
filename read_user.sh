#/bin/bash
user=$1
passwd=$2
useradd -s /bin/bash ${user}
echo -e "${passwd}"|passwd --stdin ${user}
mkdir /home/${user}/.bin
chown root. /home/${user}/.bash_profile
chmod 755 /home/${user}/.bash_profile
echo -e "PATH=/home/${user}/.bin\nexport PATH" >> /home/${user}/.bash_profile
su - ${user} -c "source /home/${user}/.bash_profile"
ln -s /usr/bin/wc /home/${user}/.bin/wc
ln -s /usr/bin/cd /home/${user}/.bin/cd
ln -s /usr/bin/tail /home/${user}/.bin/tail
ln -s /bin/more /home/${user}/.bin/more
ln -s /bin/cat /home/${user}/.bin/cat
ln -s /bin/grep /home/${user}/.bin/grep
ln -s /bin/find /home/${user}/.bin/find
ln -s /bin/pwd /home/${user}/.bin/pwd
ln -s /bin/ls /home/${user}/.bin/ls
ln -s /bin/less /home/${user}/.bin/less
ln -s /bin/tar /home/${user}/.bin/tar
ln -s /bin/echo /home/${user}/.bin/echo

# chmod a+r -R /mnt/logs