#!/bin/bash
apt-get -y install docker.io
# 给docker更换阿里源
cat <<EOF > /etc/docker/daemon.json
{
"registry-mirrors": ["https://b9pmyelo.mirror.aliyuncs.com"]
}
EOF
# 重启docker
systemctl restart docker
# 设置docker开机自启动
systemctl enable docker
# 查看docker信息
docker info
# 安装docker-compose
apt-get -y install docker-compose

exit
