#!/bin/sh

    cd /tmp
    
    wget -q -O ck-server ${CLOAK_URL}
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

    wget -q -O gq-server ${GQ_URL}
    chmod +x gq-server
    mv ${GQ_FILE} /usr/bin
    if [ $? -eq 0 ]; then
        echo -e "\033[32m[INFO] GoQuiet Successful installation.."
    else
        echo
        echo -e "\033[31m[ERROR] GoQuiet installation failed.."
        echo
        exit 1
    fi

    wget -q ${KCPTUN_DL}
    tar zxf ${KCPTUN_FILE}-${KCPTUN_VER}.tar.gz
    mv server_linux_amd64 /usr/bin/kcptun-server
    if [ $? -eq 0 ]; then
        echo -e "\033[32m[INFO] kcptun Successful installation.."
    else
        echo
        echo -e "\033[31m[ERROR] kcptun installation failed.."
        echo
        exit 1
    fi
    
       wget -q ${V2RAY_DL}
    tar zxf ${V2RAY_FILE}-${V2RAY_VER}.tar.gz
    mv v2ray-plugin_linux_amd64 /usr/bin/v2ray-plugin
    if [ $? -eq 0 ]; then
        echo -e "\033[32m[INFO] v2ray-plugin Successful installation.."
    else
        echo
        echo -e "\033[31m[ERROR] v2ray-plugin installation failed.."
        echo
        exit 1
    fi
    
    
"$@"
