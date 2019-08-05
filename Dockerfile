FROM  alpine:3.10   

ENV SSLIBEV_DL=https://github.com/shadowsocks/shadowsocks-libev.git \
TINC_DL=https://www.tinc-vpn.org/packages/tinc-1.1pre17.tar.gz \
PURPLEI2P_DL=https://github.com/PurpleI2P/i2pd.git \
CLOAK_URL=https://github.com/cbeuw/Cloak/releases/download/v1.1.2/ck-server-linux-amd64-1.1.2 \
CLOAK_FILE=ck-server \
GQ_URL=https://github.com/cbeuw/GoQuiet/releases/download/v1.2.2/gq-server-linux-amd64-1.2.2 \
GQ_FILE=gq-server \
KCPTUN_DL=https://github.com/xtaci/kcptun/releases/download/v20190718/kcptun-linux-amd64-20190718.tar.gz \
KCPTUN_FILE=kcptun-linux-amd64 \
KCPTUN_VER=20190718 \
V2RAY_DL=https://github.com/shadowsocks/v2ray-plugin/releases/download/v1.1.0/v2ray-plugin-linux-amd64-v1.1.0.tar.gz \
V2RAY_FILE=v2ray-plugin-linux-amd64 \
V2RAY_VER=v1.1.0 \
OBFS_DL=https://github.com/shadowsocks/simple-obfs/archive/v0.0.5.tar.gz

RUN apk update && apk add --no-cache --virtual build-deps \
    autoconf automake build-base make libev-dev libtool udns-dev libsodium-dev mbedtls-dev pcre-dev c-ares-dev readline-dev xz-dev \
    linux-headers curl openssl-dev zlib-dev git gcc g++ gmp-dev lzo-dev libpcap-dev zstd-dev sudo \
    musl-dev curl  boost-dev miniupnpc-dev sqlite-dev gd-dev geoip-dev libmaxminddb-dev libxml2-dev libxslt-dev paxmark perl-dev pkgconf && \
    
    cd /tmp && wget ${TINC_DL} && tar -xzvf tinc-1.1pre17.tar.gz && \
    cd tinc-1.1pre17 && ./configure --prefix=/usr --enable-jumbograms --enable-tunemu --sysconfdir=/etc --localstatedir=/var > /dev/null && make && sudo make install && \
    #
    cd /tmp && git clone --depth=1 ${SSLIBEV_DL} && \
    cd shadowsocks-libev && git submodule update --init --recursive && ./autogen.sh && ./configure --prefix=/usr --disable-documentation > /dev/null && make && \
    make install && \
    #
    cd /tmp && git clone ${PURPLEI2P_DL} && \
    cd i2pd && make && \
    
rm -rf /tmp/* && \
apk --no-cache --purge del build-deps



ADD config /config
RUN sh /config/installer.sh


