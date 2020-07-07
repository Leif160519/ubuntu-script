# 注意事项
## 1.此脚本适用于Ubuntu 20.04（desktop或者live版本）。
## 2.部分脚本在运行过程中自带彩色字体输出，某些脚本执行一定步骤之后需要手动与控制台进行交互，并非无人值守，执行前请先阅读脚本内容。

# 文件介绍

## 1.base.sh
ubuntu基础环境配置，安装必备组件和一些运维组件：

## 2.docker.sh
安装docker和docker-compose并更换成阿里源

## 3. gitlab.sh
ubuntu安装gitlab，选择源安装是最新版，直接下载安装包是13.1.3版本

## 4.network.sh
ubuntu 配置有线固定IP地址

> 注意：ubuntu从17.04开始抛弃`/etc/network/interfaces`方式设置固定IP地址（`debian`仍支持），采用`netplan`的方式设置。通常情况下，desktop和live版本的ubuntu都支持`netplan`方式，只不过desktop采用netplan设置之后，进入`设置-网络`中查看网络设置，显示的还是`dhcp`状态，而desktop版本还支持在`/etc/NetworkManager/system-connections/`路径下配置固定IP的方式（桌面版设置中手动点击设置的固定IP），而此方式live版不支持。

## 5.nfs.sh
安装nfs文件共享（默认无密码）

## 6.samba.sh
安装samba文件共享（密码设置需与控制台交互）
