# 注意事项
## 1.此脚本适用于Ubuntu 20.04（desktop或者live版本）。
## 2.部分脚本在运行过程中自带彩色字体输出，某些脚本执行一定步骤之后需要手动与控制台进行交互，并非无人值守，执行前请先阅读脚本内容。

# 文件介绍

## 1.base.sh
ubuntu基础环境配置，安装必备组件和一些运维组件：

| 序号 | 软件名称 | 说明 | 使用方法 |
| --- | --- | --- | --- |
| 1 | openjdk-8-jre-headless | 开源jdk8 |  |
| 2 | htop | 实时的监控界面 | [htop使用详解--史上最强（没有之一）](https://cloud.tencent.com/developer/article/1115041) |
| 3 | iotop | iotop命令是一个用来监视磁盘I/O使用状况的top类工具 | [iotop命令](https://man.linuxde.net/iotop) |
| 4 | iftop | 查看实时的网络流量，监控TCP/IP连接等 | [Linux流量监控工具 - iftop (最全面的iftop教程)](https://www.vpser.net/manage/iftop.html) |
| 5 | nethogs | NetHogs是一个开源的命令行工具（类似于Linux的top命令），用来按进程或程序实时统计网络带宽使用率 | [nethogs命令](https://man.linuxde.net/nethogs) |
| 6 | cacti | Cacti是一套基于PHP、MySQL、SNMP及RRDTool开发的网络流量监测图形分析工具 | [Linux 监控工具之Cacti使用详解（一）](https://blog.51cto.com/freeloda/1308140) |
| 7 | npm | NPM是随同NodeJS一起安装的包管理工具 | [NPM 使用介绍](https://www.runoob.com/nodejs/nodejs-npm.html) |
| 8 | pv | 显示当前在命令行执行的命令的进度信息，管道查看器 | [pv](https://wangchujiang.com/linux-command/c/pv.html) |
| 9 | net-tools | 网络工具包 |  |
| 10 | tree | tree命令以树状图列出目录的内容 | [tree命令](https://man.linuxde.net/tree) |
| 11 | tmux | tmux是一款优秀的终端复用软件 | [Tmux使用手册](http://louiszhai.github.io/2017/09/30/tmux/) / [Tmux 使用教程](https://www.ruanyifeng.com/blog/2019/10/tmux.html) |
| 12 | iperf | iperf命令是一个网络性能测试工具 | [iperf命令](https://man.linuxde.net/iperf) |
| 13 | figlet | 将普通终端文本转换为大字母 | [Figlet 和 Toilet命令用法](https://www.linuxprobe.com/figlet-toilet-command.html) |
| 14 | lsof | lsof命令用于查看你进程开打的文件，打开文件的进程，进程打开的端口(TCP、UDP) | [lsof命令](https://man.linuxde.net/lsof) |
| 15 | smartmontools | 是类Unix系统下实施SMART任务命令行套件或工具，它用于打印SMART自检和错误日志，启用并禁用SMRAT自动检测，以及初始化设备自检 | [Linux 硬盘监控和分析工具：smartctl](https://leif.fun/articles/2019/08/22/1566473324516.html) |
| 16 | fping | Fping程序类似于ping协议回复请求以检测主机是否存在 | [Fping命令解析](https://blog.csdn.net/wz_cow/article/details/80967255) |
| 17 | nmap | nmap命令是一款开放源代码的网络探测和安全审核工具，它的设计目标是快速地扫描大型网络 | [nmap命令](https://man.linuxde.net/nmap) |
| 18 | fio | fio是一个IO测试工具，可以运行在Linux、Windows等多种系统之上，可以用来测试本地磁盘、网络存储等的性能 | [fio的简单介绍及部分参数翻译](https://blog.csdn.net/MrSate/article/details/53292102) |
| 19 | iostat | iostat命令被用于监视系统输入输出设备和CPU的使用情况 | [iostat命令](https://man.linuxde.net/iostat) |
| 20 | dstat | dstat命令是一个用来替换vmstat、iostat、netstat、nfsstat和ifstat这些命令的工具 | [dstat命令](https://man.linuxde.net/dstat) |
| 21 | lynx | lynx命令是终端上的纯文本模式的网页浏览器，没有JS引擎，不支持CSS排版、图形、音视频等多媒体信息。只能作为一个很有趣的小玩具。| [lynx命令 – 终端上的纯文本浏览器](https://www.linuxcool.com/lynx) |
| 22 | w3m | w3m是个开放源代码的命令行下面的网页浏览器。| [w3m常用操作](http://blog.lujun9972.win/blog/2016/12/11/w3m%E5%B8%B8%E7%94%A8%E6%93%8D%E4%BD%9C/index.html) |
| 23 | lrzsz | rz：运行该命令会弹出一个文件选择窗口，从本地选择文件上传到服务器(receive)，即windows上传到linux服务器;sz：将选定的文件发送（send）到本地机器，即从linux服务型下载到windows ||
| 24 | monit | Monit是一款功能非常丰富的进程、文件、目录和设备的监测软件，适用于Linux/Unix平台。它可以自动修复那些已经停止运作的程序，特别适合处理那些由于多种原因导致的软件错误、监控系统关键的进程和资源。同时Monit 包含一个内嵌的 HTTP(S) Web 界面，你可以使用浏览器方便地查看 Monit 所监视的服务器。此外，M/Monit可以把多台安装Monit的服务器集中起来一起管理。| [Monit：开源服务器监控工具](https://www.cnblogs.com/52fhy/p/6412547.html) |
| 25 | ntpdate | ntpdate命令是用来设置本地日期和时间。它从指定的每个服务器获得了一些样本，并应用标准 NTP 时钟过滤器和选择算法来选择最好的样本。 | [ntpdate命令](https://man.linuxde.net/ntpdate)|

其他软件及操作
|  序号 |  软件/操作名称 |  作用 |
| --- | --- | --- |
| 1 | 关闭swap分区 |  |
| 2 | 屏蔽系统错误报告 |  |
| 3 | screenfetch | 查看系统信息 |
| 4 | neofetch | 查看系统信息 |
| 5 | 关闭SSH DNS反向解析和GSSAPI的用户认证  | 防止ssh超时掉线 |

> 补充：[Linux 常用命令集合](https://www.runoob.com/w3cnote/linux-common-command.html)

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
