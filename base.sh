#!/bin/bash
# 更换阿里源
cp /etc/apt/sources.list /etc/apt/sources.list.bak
cat <<EOF > /etc/apt/sources.list
deb http://mirrors.aliyun.com/ubuntu/ focal main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ focal main restricted universe multiverse

deb http://mirrors.aliyun.com/ubuntu/ focal-security main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ focal-security main restricted universe multiverse

deb http://mirrors.aliyun.com/ubuntu/ focal-updates main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ focal-updates main restricted universe multiverse

deb http://mirrors.aliyun.com/ubuntu/ focal-proposed main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ focal-proposed main restricted universe multiverse

deb http://mirrors.aliyun.com/ubuntu/ focal-backports main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ focal-backports main restricted universe multiverse
EOF

# 更新和升级
apt-get -y update
apt-get -y upgrade

echo -e "\033[1;32m  安装openssh-server \033[0m"
apt-get -y install openssh-server 
echo -e "\033[1;32m  安装tree \033[0m"
apt-get -y install tree 
echo -e "\033[1;32m  安装curl \033[0m"
apt-get -y install curl
echo -e "\033[1;32m  安装htop \033[0m"
apt-get -y install htop
echo -e "\033[1;32m  安装ctop \033[0m"
apt-get -y install ctop
echo -e "\033[1;32m  安装iotop \033[0m"
apt-get -y install iotop
echo -e "\033[1;32m  安装iftop \033[0m"
apt-get -y install iftop
echo -e "\033[1;32m  安装nethogs \033[0m"
apt-get -y install nethogs
echo -e "\033[1;32m  安装net-tools \033[0m"
apt-get -y install net-tools 
echo -e "\033[1;32m  安装iostat \033[0m"
apt-get -y install sysstat
echo -e "\033[1;32m  安装fio \033[0m"
apt-get -y install fio
echo -e "\033[1;32m  安装fping \033[0m"
apt-get -y install fping 
echo -e "\033[1;32m  安装iperf \033[0m"
apt-get -y install iperf
echo -e "\033[1;32m  安装screenfetch \033[0m"
apt-get -y install screenfetch 
echo -e "\033[1;32m  安装neofetch \033[0m"
apt-get -y install neofetch 
echo -e "\033[1;32m  安装expect \033[0m"
apt-get -y install expect
echo -e "\033[1;32m  安装ntpdate \033[0m"
apt-get -y install ntpdate
echo -e "\033[1;32m  安装w3m \033[0m"
apt-get -y install w3m
echo -e "\033[1;32m  安装lynx \033[0m"
apt-get -y install lynx
echo -e "\033[1;32m  安装ansible \033[0m"
apt-get -y install ansible

# 设置SSH
echo -e '\033[1;31m 关闭SSH DNS反向解析和GSSAPI的用户认证 \033[0m'
sed -i "s/#UseDNS no/UseDNS no/g" /etc/ssh/sshd_config
sed -i "s/#GSSAPIAuthentication no/GSSAPIAuthentication no/g" /etc/ssh/sshd_config
echo -e '\033[1;32m 解决SSH掉线问题 \033[0m'
sed -i "s/#ClientAliveInterval 0/ClientAliveInterval 60/g" /etc/ssh/sshd_config
sed -i "s/#ClientAliveCountMax 3/ClientAliveCountMax 60/g" /etc/ssh/sshd_config
echo -e '\033[1;32m 重启sshd服务 \033[0m'
systemctl restart sshd
# 设置sudoers
echo -e "\033[1;31m  设置所有sudo指令不需要密码 \033[0m"
sed -i "s/%sudo[[:space:]]*ALL=(ALL:ALL) ALL/%sudo    ALL=(ALL:ALL) NOPASSWD:ALL/g" /etc/sudoers
# 屏蔽系统错误报告
echo -e "\033[1;31m  屏蔽系统错误报告 \033[0m"
rm -rf /var/crash/*
sed -i "s/enabled=1/enabled=0/g" /etc/default/apport
# 关闭swap分区
echo -e '\033[1;31m 永久关闭swap分区（重启后生效） \033[0m'
#swapoff -a 临时关闭
sed -i "s/\/swapfile/#\/swapfile/g" /etc/fstab 


echo -e '\033[1;32m 系统初始化配置完成！\033[0m'
echo -e "\033[1;32m 清理安装包 \033[0m"
apt-get autoclean
apt-get clean
apt -y autoremove --purge snapd

function choose_reboot(){
    echo -n "是否重启？(y or n)"
    read choice
    if [ ${choice} == "y" ];then
        echo -e '\033[1;31m 你选择了重启 \033[0m'
        reboot
    elif [ ${choice} == "n" ];then
        echo "你选择了不重启"
    else
        echo "输入有误，请重新输入"
        choice
    fi
}
choose_reboot


exit
