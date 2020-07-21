#!/bin/bash
# 源码编译Python2.7

function choice(){
    echo -n "请选择编译安装的Python版本(2.7.18或者3.8.3,输入2或者3)："
    read python_version

    if [[ ${python_version} == "2" ]];then
        echo "你选择了安装python2"
        python_short_version=2.7
        python_ln_version=""
        python_detail_version=2.7.18
    elif [[ ${python_version} == "3" ]];then
        echo "你选择了安装python3"
        python_short_version=3.8
        python_ln_version=3
        python_detail_version=3.8.3
    else
       echo "输入有误，请重新输入"
        choice
    fi
}

choice



function install_python(){
wget -c https://www.python.org/ftp/python/${python_detail_version}/Python-${python_detail_version}.tgz
tar -xzvf Python-${python_detail_version}.tgz
cd Python-${python_detail_version}/
./configure --prefix=/usr/local/python${python_short_version}
make
make install 
# 设置软连接
rm -f /usr/bin/python${python_ln_version}
rm -f /usr/bin/pip${python_ln_version}
ln -s /usr/local/python${python_short_version}/bin/python${python_ln_version} /usr/bin/python${python_ln_version}
ln -s /usr/local/python${python_short_version}/bin/pip${python_ln_version} /usr/bin/pip${python_ln_version}
# 查看Python版本
python${python_ln_verson} -V
# 查看pip版本
pip${python_ln_verson}  -V 
}

# 安装Python
install_python
exit
