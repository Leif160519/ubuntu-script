#!/bin/bash
#卸载掉gnome-shell主程序
apt-get -y remove gnome-shell

#卸载掉gnome
apt-get -y remove gnome

#卸载不需要的依赖关系
apt-get autoremove

#彻底删除gnome的相关配置文件
apt-get purge gnome

#清理安装gnome时候留下的缓存程序软件包
apt-get autoclean
apt-get clean

#重启生效
function choose_reboot(){
    echo -n "是否重启？(y or n)"
    read choice
    if [ ${choice} == "y" ];then
        echo "你选择了重启"
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
