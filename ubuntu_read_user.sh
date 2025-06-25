#!/bin/bash

user="$1"
passwd="$2"

# 检查用户是否已存在
if id "$user" &>/dev/null; then
    echo "用户 $user 已存在，跳过创建。"
else
    echo "创建用户 $user..."
    useradd -m -s /bin/bash "$user"
    echo "${user}:${passwd}" | chpasswd
fi

# 确保 home 目录存在
HOME_DIR="/home/${user}"
BIN_DIR="${HOME_DIR}/.bin"

if [ ! -d "$HOME_DIR" ]; then
    echo "用户目录 $HOME_DIR 不存在，手动创建..."
    mkdir -p "$HOME_DIR"
    chown "$user:$user" "$HOME_DIR"
fi

# 创建 .bin 目录
mkdir -p "$BIN_DIR"

# 创建 .bash_profile
BASH_PROFILE="${HOME_DIR}/.bash_profile"
cat > "$BASH_PROFILE" <<EOF
PATH=${BIN_DIR}:\$PATH
export PATH
EOF

chown root:root "$BASH_PROFILE"
chmod 755 "$BASH_PROFILE"

# 链接常用命令（排除 cd）
ln -sf /usr/bin/wc   "${BIN_DIR}/wc"
ln -sf /usr/bin/tail "${BIN_DIR}/tail"
ln -sf /bin/more     "${BIN_DIR}/more"
ln -sf /bin/cat      "${BIN_DIR}/cat"
ln -sf /bin/grep     "${BIN_DIR}/grep"
ln -sf /usr/bin/find "${BIN_DIR}/find"
ln -sf /bin/pwd      "${BIN_DIR}/pwd"
ln -sf /bin/ls       "${BIN_DIR}/ls"
ln -sf /bin/less     "${BIN_DIR}/less"
ln -sf /bin/tar      "${BIN_DIR}/tar"
ln -sf /bin/echo     "${BIN_DIR}/echo"

# 修正权限
chown -R "$user:$user" "$BIN_DIR"

echo "✅ 用户 $user 设置完成"