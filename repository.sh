#!/bin/bash
source_url="http://mirrors.aliyun.com/ubuntu/"
code_name=$(lsb_release -c | awk '{print $2}')

# 更换阿里源
echo -e "\033[1;31m  更换阿里源 \033[0m"
cp /etc/apt/sources.list /etc/apt/sources.list.bak
cat <<EOF > /etc/apt/sources.list
deb ${source_url} ${code_name} main restricted universe multiverse
deb-src ${source_url} ${code_name} main restricted universe multiverse

deb ${source_url} ${code_name}-security main restricted universe multiverse
deb-src ${source_url} ${code_name}-security main restricted universe multiverse

deb ${source_url} ${code_name}-updates main restricted universe multiverse
deb-src ${source_url} ${code_name}-updates main restricted universe multiverse

deb ${source_url} ${code_name}-proposed main restricted universe multiverse
deb-src ${source_url} ${code_name}-proposed main restricted universe multiverse

deb ${source_url} ${code_name}-backports main restricted universe multiverse
deb-src ${source_url} ${code_name}-backports main restricted universe multiverse
EOF

# 更新和升级
apt-get -y update
apt-get -y upgrade
