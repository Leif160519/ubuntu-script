#!/bin/bash
echo -e '\033[1;32m 安装初始环境 \033[0m'
echo -e '\033[1;32m 1.安装常用软件或工具包 \033[0m'

for software_name in rar unrar 7zip-full python-pip screenfetch neofetch linuxlogo \
    silversearcher-ag mycli shellcheck fzf icdiff ranger tldr  \
    wget nano vim emacs zip unzip git openjdk-8-jre-headless expect htop iotop iftop nethogs \
    nagios mrtg npm pv telnet net-tools tree tmux iperf lsof dpkg hdparm smartmontools \
    psmisc fping tcpdump nmap fio nc strace perf build-utils dstat lynx w3m lrzsz \
    monit ntp bash-completion ctop ansible dosfstools uuid make colordiff subnetcalc groovy \
    python python3 python3-pip dos2unix nload curl cifs-utils xfsprogs exfat-utils rename \
    curlftpfs tig jq mosh axel cloc ccache neovim mc powerman ncdu glances pcp multitail \
    figlet wdiff smartmontools ntpdate lsb fortune-mod ethtool lvm2 enca nload iptraf bmon \
    slurm tcptrack vnstat bwm-ng ifstat collectl zstd moreutils nvme-cli unhide ;
do
    echo -e "\033[1;32m 安装${software_name} \033[0m"
    apt-get -y install "${software_name}"
done

echo -e '\033[1;32m 2.启动相关服务 \033[0m'
for software_name in sysstat monit;
do
    systemctl start "${software_name}"
    systemctl enable "${software_name}"
done

echo -e '\033[1;32m 系统初始化配置完成！\033[0m'
echo -e "\033[1;32m 清理安装包 \033[0m"
apt-get autoclean
apt-get clean
apt -y autoremove --purge snapd

exit
