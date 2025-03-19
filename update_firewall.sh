#!/bin/bash

# 定义需要重新添加的白名单 IP
WHITELIST_IPS=(
    "45.78.17.247" # hk-14
    "47.254.86.140" # amazon-transfer
    "47.97.109.44" # jenkins
    "144.34.224.56" # uptime
    "144.34.238.10" # bwg-55
    "110.80.26.62" # 公司本地
)

# 检查 firewalld 是否运行
if ! systemctl is-active --quiet firewalld; then
    echo "Firewalld 未运行，启动中..."
    systemctl start firewalld
fi

# 清除所有已添加的白名单 IP（移除所有 rich rule 规则）
echo "清除现有的 IP 白名单..."
for ip in $(firewall-cmd --list-rich-rules | grep -oP 'source address="\K[^"]+'); do
    firewall-cmd --permanent --remove-rich-rule="rule family='ipv4' source address='$ip' accept"
    echo "已删除白名单 IP: $ip"
done

# 重新添加新的 IP 白名单
echo "添加新的 IP 白名单..."
for ip in "${WHITELIST_IPS[@]}"; do
    firewall-cmd --permanent --add-rich-rule="rule family='ipv4' source address='$ip' accept"
    echo "已添加白名单 IP: $ip"
done

# 重新加载防火墙规则
firewall-cmd --reload
echo "防火墙规则已更新！"

firewall-cmd --list-all
systemctl restart firewalld
systemctl restart docker