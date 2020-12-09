#!/bin/bash
echo "查看IP地址："
ip a
echo -n "请输入网卡设备号："
read -r interface
echo -n "请输入IP地址并跟上子网掩码，如：192.168.0.1/24："
read -r ip_address
echo -n "请输入网关地址："
read -r gateway_adress
echo -n "请输入dns地址，若有多个dns，请用英文逗号隔开："
read -r dns_adress

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
        search: []
      dhcp4: no
  version: 2
  renderer: networkd
EOF

# 让配置生效
netplan apply

echo "查看IP地址："
ip a

exit
