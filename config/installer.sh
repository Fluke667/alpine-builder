#!/bin/sh

    cd /tmp

    wget -q -O ck-server https://github.com/cbeuw/Cloak/releases/download/v1.1.2/ck-server-linux-amd64-1.1.2
    chmod +x ck-server
    cp ck-server /usr/bin
    if [ $? -eq 0 ]; then
        echo -e "\033[32m[INFO] Cloak Successful installation.."
    else
        echo
        echo -e "\033[31m[ERROR] Cloak installation failed.."
        echo
        exit 1
    fi

    wget -q -O gq-server https://github.com/cbeuw/GoQuiet/releases/download/v1.2.2/gq-server-linux-amd64-1.2.2
    chmod +x gq-server
    mv gq-server /usr/bin
    if [ $? -eq 0 ]; then
        echo -e "\033[32m[INFO] GoQuiet Successful installation.."
    else
        echo
        echo -e "\033[31m[ERROR] GoQuiet installation failed.."
        echo
        exit 1
    fi

    wget -q https://github.com/xtaci/kcptun/releases/download/v20190718/kcptun-linux-amd64-20190718.tar.gz
    tar zxf kcptun-linux-amd64-20190718.tar.gz
    mv server_linux_amd64 /usr/bin/kcptun-server
    if [ $? -eq 0 ]; then
        echo -e "\033[32m[INFO] kcptun Successful installation.."
    else
        echo
        echo -e "\033[31m[ERROR] kcptun installation failed.."
        echo
        exit 1
    fi
      
       wget -q https://github.com/shadowsocks/v2ray-plugin/releases/download/v1.1.0/v2ray-plugin-linux-amd64-v1.1.0.tar.gz
    tar zxf v2ray-plugin-linux-amd64-v1.1.0.tar.gz
    mv v2ray-plugin_linux_amd64 /usr/bin/v2ray-plugin
    if [ $? -eq 0 ]; then
        echo -e "\033[32m[INFO] v2ray-plugin Successful installation.."
    else
        echo
        echo -e "\033[31m[ERROR] v2ray-plugin installation failed.."
        echo
        exit 1
    fi

ls /usr/bin

"$@"

