#!/bin/bash
apt-get -y install docker.io
# 给docker更换阿里源
cat <<EOF > /etc/docker/daemon.json
{
"registry-mirrors": ["https://b9pmyelo.mirror.aliyuncs.com"]
}
EOF

# 若想更换docker网卡的网段，则json内容如下
#{
#"default-address-pools": [
#	{
#		"base": "198.18.0.0/16",
#		"size": 24
#		}
#	],
#  "registry-mirrors": ["https://b9pmyelo.mirror.aliyuncs.com"]
#}
# 重启docker
systemctl restart docker
# 设置docker开机自启动
systemctl enable docker
# 查看docker信息
docker info
# 安装docker-compose
apt-get -y install docker-compose

exit
