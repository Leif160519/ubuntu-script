#!/bin/bash
# 设置SSH
echo -e '\033[1;31m 1.关闭SSH DNS反向解析和GSSAPI的用户认证 \033[0m'
sed -i "s/#UseDNS no/UseDNS no/g" /etc/ssh/sshd_config
sed -i "s/#GSSAPIAuthentication no/GSSAPIAuthentication no/g" /etc/ssh/sshd_config
echo -e '\033[1;32m 解决SSH掉线问题 \033[0m'
sed -i "s/#ClientAliveInterval 0/ClientAliveInterval 60/g" /etc/ssh/sshd_config
sed -i "s/#ClientAliveCountMax 3/ClientAliveCountMax 60/g" /etc/ssh/sshd_config
echo -e '\033[1;32m 重启sshd服务 \033[0m'
systemctl restart sshd

# 设置sudoers
echo -e "\033[1;31m 2.设置所有sudo指令不需要密码 \033[0m"
sed -i "s/%sudo[[:space:]]*ALL=(ALL:ALL) ALL/%sudo    ALL=(ALL:ALL) NOPASSWD:ALL/g" /etc/sudoers

# 屏蔽系统错误报告
echo -e "\033[1;31m 3.屏蔽系统错误报告 \033[0m"
rm -rf /var/crash/*
sed -i "s/enabled=1/enabled=0/g" /etc/default/apport

# 关闭swap分区
echo -e '\033[1;31m 4.永久关闭swap分区（重启后生效） \033[0m'
#swapoff -a 临时关闭
sed  -i '/swap/s/^/#/' /etc/fstab

# 给pip换源
echo -e '\033[1;32m 5.给pip换源 \033[0m'
mkdir -p /root/.pip
cat <<EOF > /root/.pip/pip.conf
[global]
index-url = http://mirrors.aliyun.com/pypi/simple/
[install]
trusted-host=mirrors.aliyun.com
EOF

# 配置vim
echo -e '\033[1;32m 6.配置vim \033[0m'
cat <<EOF >> /etc/vim/vimrc
set foldmethod=marker
highlight RedundantSpaces ctermbg=red guibg=red
match RedundantSpaces /\s\+$\| \+\ze\t\|\t/
set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=4
set fileformats=unix
EOF

# 配置关机等待时间
echo -e '\033[1;32m 7.配置关机等待时间 \033[0m'
sed -i "/^#DefaultTimeoutStartSec/cDefaultTimeoutStartSec=10s" /etc/systemd/system.conf
sed -i "/^#DefaultTimeoutStopSec/cDefaultTimeoutStopSec=10s" /etc/systemd/system.conf

function choose_reboot(){
    echo -n "是否重启？(y or n)"
    read -r choice
    if [ "${choice}" == "y" ];then
        echo -e '\033[1;31m 你选择了重启 \033[0m'
        reboot
    elif [ "${choice}" == "n" ];then
        echo "你选择了不重启"
    else
        echo "输入有误，请重新输入"
        choice
    fi
}
choose_reboot

exit
