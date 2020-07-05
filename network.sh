#!/bin/bash
echo "查看IP地址："
ip a
echo -n "请输入网卡设备号："
read interface
echo -n "请输入IP地址："
read ip_address
echo -n "请输入网关地址："
read gateway_adress
echo -n "请输入dns地址，若有多个dns，请用英文逗号隔开："
read dns_adress

# 添加共享目录
cat <<EOF > /etc/netplan/*.yaml
# This is the network config written by 'subiquity'
network:
  ethernets:
    ${interface}:
      addresses: [${ip_address}/24]
      optional: true
      gateway4: ${gateway_adress}
      nameservers:
        addresses: [${dns_adress}]
      dhcp4: no
  version: 2
  renderer: networkd
EOF

# 让配置生效
netplan apply

echo "查看IP地址："
ip a

exit
