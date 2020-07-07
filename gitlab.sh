#!/bin/bash
#获取本机ip地址
echo -e '\033[1;32m 获取本机IP地址 \033[0m'
ip_address=`ip a | grep inet | grep -v inet6 | grep -v 127 | sed 's/^[ \t]*//g' | cut -d ' ' -f2 | grep -v 172 | cut -d '/' -f1 | head -1`
# 安装依赖包
echo -e '\033[1;32m 安装依赖包 \033[0m'
apt-get -y install curl
apt-get -y install openssh-server
apt-get -y install ca-certificates
apt-get -y install postfix

# 安装gitlab-ce
echo -e '\033[1;32m 安装gitlab-ce \033[0m'
function apt_install(){
# 信任Gitlab的GPG公钥
echo -e '\033[1;32m 信任gitlab的GPG公钥 \033[0m'
curl https://packages.gitlab.com/gpg.key 2> /dev/null | sudo apt-key add - &>/dev/null

# 生成源文件
echo -e '\033[1;32m 生成源文件 \033[0m'
cat <<EOF >/etc/apt/sources.list.d/gitlab-ce.list
deb https://mirrors.tuna.tsinghua.edu.cn/gitlab-ce/ubuntu/ xenial main
deb-src https://mirrors.tuna.tsinghua.edu.cn/gitlab-ce/ubuntu/ xenial main
EOF

# 更新
echo -e '\033[1;32m 更新 \033[0m'
apt-get -y update
apt-get -y install gitlab-ce

}

function package_install(){
# 下载gitlab安装包
echo -e '\033[1;32m 下载gitlab安装包 \033[0m'
wget https://mirrors.tuna.tsinghua.edu.cn/gitlab-ce/ubuntu/pool/xenial/main/g/gitlab-ce/gitlab-ce_13.1.3-ce.0_amd64.deb
dpkg -i  gitlab-ce_13.1.3-ce.0_amd64.deb
}

echo -n -e "\033[1;32m 请选择安装方式（1.更新源安装，2.直接下载安装包）： \033[0m"
read choice

function choice(){
  if [[ ${choice} == "1" ]];then
    echo -e '\033[1;32m 你选择了第1种，更新源安装 \033[0m'
    apt_install
  elif [[ ${choice} == "2" ]];then
    echo -e '\033[1;32m 你选择了第2种，直接下载安装包 \033[0m'
    package_install
  else
    echo -e '\033[1;32m 输入有误，请重新输入 \033[0m'
    choice
  fi
}

choice


# gitlab配置
echo -e '\033[1;32m 添加定时任务，每天凌晨两点，执行gitlab备份 \033[0m'
sed -i '$a\0  2    * * *   root    /opt/gitlab/bin/gitlab-rake gitlab:backup:create CRON=1' /etc/crontab
echo -e '\033[1;31m 加载任务,使之生效 \033[0m'
crontab /etc/crontab
echo -e '\033[1;32m 查看任务 \033[0m'
crontab -l
echo -e '\033[1;32m 自动编辑gitlab配置文件，设置域名和文件保存时间，默认保存7天 \033[0m'
sed -i "s/external_url 'http:\/\/gitlab.example.com'/external_url 'http:\/\/${ip_address}'/g" /etc/gitlab/gitlab.rb
sed -i "s/# gitlab_rails\['backup_keep_time'\] = 604800/gitlab_rails\['backup_keep_time'\] = 604800/g" /etc/gitlab/gitlab.rb
echo -e '\033[1;32m 更新配置并重启 \033[0m'
gitlab-ctl reconfigure
echo -e '\033[1;32m 查看gitlab服务启动状态 \033[0m'
gitlab-ctl status
echo -e '\033[1;32m 使用以下指令启动|停止|查看状态|重启服务管理gitlab \033[0m'
echo -e '\033[1;33m gitlab-ctl start|stop|status|restart \033[0m'
echo -e '\033[1;31m GitLab配置完成！\033[0m'

exit
