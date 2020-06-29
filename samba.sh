#!/bin/bash
apt-get -y install samba
echo -n "请输入需要共享的目录（不存在则会自动创建）："
read share_dir
mkdir -p ${share_dir}
chmod -R 777 ${share_dir}
echo -n "请输入共享的名称（别名）："
read share_name
echo -n "添加samba用户名："
read smb_user
smbpasswd -a ${smb_user}

# 添加共享目录
cat <<EOF >> /etc/samba/smb.conf
[${share_name}]
   comment = ${share_name}
   browseable = yes
   path = ${share_dir}
   create mask = 0700
   directory mask = 0700
   valid users = ${smb_user}
   force user = ${smb_user}
   force group = ${smb_user}
   public = yes
   available = yes
   writable = yes
EOF
# 重启samba
systemctl restart smbd
# 设置samba开机自启动
systemctl enable smbd

exit
