#!/bin/bash
# 卸载用apt安装的mysql，非使用mysql.sh安装的mysql
# 变量定义
mysql_root_dir="/var/lib/mysql"
mysql_config_dir="/etc/mysql"
mysql_log_dir="/var/log/mysql"
mysql_autostart_file="/etc/init.d/mysql"
mysql_sock_dir1="/var/run/mysqld"
mysql_sock_dir2="/run/mysqld"
mysql_share_dir="/usr/share/mysql"

# stop mysql service
systemctl stop mysql
systemctl disable mysql

# 卸载与mysql相关的所有软件包
dpkg -l | grep mysql  | awk '{print $2}' | xargs apt-get remove --purge -y
dpkg -l | grep mysql  | awk '{print $2}' | xargs apt-get autoremove --purge -y

# 删除启动文件
find ${mysql_autostart_file} -delete

# 删除mysql运行路径
find ${mysql_root_dir} -delete

# 删除mysql配置文件路径
find ${mysql_config_dir} -delete

# 删除mysql日志路径
find ${mysql_log_dir} -delete

# 删除mysql.sock路径
find ${mysql_sock_dir1} -delete
find ${mysql_sock_dir2} -delete

# 删除其他mysql相关路径
find ${mysql_share_dir} -delete

# 删除所有mysql开头的路径或文件
find / -type f -name mysql\* -delete

# 清除无用依赖
apt-get remove --purge
apt-get autoremove --purge

# 清理缓存程序安装包
apt-get clean
apt-get autoclean

exit
