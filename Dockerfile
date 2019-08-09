FROM  alpine:3.10   

ENV SSLIBEV_DL=https://github.com/shadowsocks/shadowsocks-libev.git \
TINC_DL=https://www.tinc-vpn.org/packages/tinc-1.1pre17.tar.gz \
PURPLEI2P_DL=https://github.com/PurpleI2P/i2pd.git \
LIBCORK_DL=https://github.com/shadowsocks/libcork/archive/29d7cbafc4b983192baeb0c962ab1ff591418f56.tar.gz \
OBFS_DL=https://github.com/shadowsocks/simple-obfs/archive/v0.0.5.tar.gz \
SSLH_DL=https://github.com/yrutschle/sslh/archive/v1.20.tar.gz

RUN echo "http://dl-4.alpinelinux.org/alpine/edge/testing/" >> /etc/apk/repositories && \
    apk update && apk add --no-cache --virtual build-deps \
    autoconf automake build-base make libev-dev libtool udns-dev libsodium-dev mbedtls-dev pcre-dev c-ares-dev readline-dev \
    xz-dev linux-headers curl openssl-dev zlib-dev git gcc g++ gmp-dev lzo-dev zstd-dev sudo libconfig libconfig-dev \
    perl perl-dev musl-dev boost-dev miniupnpc-dev sqlite-dev gd-dev geoip-dev libmaxminddb-dev libxml2-dev libxslt-dev \
    paxmark pkgconf perl-conf-libconfig perl-io-socket-inet6 lcov valgrind libcap libpcap-dev && \
    # tinc
    cd /tmp && wget ${TINC_DL} && tar -xzvf tinc-1.1pre17.tar.gz && \
    cd tinc-1.1pre17 && ./configure --prefix=/usr --enable-jumbograms --enable-tunemu --sysconfdir=/etc --localstatedir=/var > /dev/null && make && sudo make install && \
    # shadosocks-libev
    cd /tmp && git clone --depth=1 ${SSLIBEV_DL} && \
    cd shadowsocks-libev && git submodule update --init --recursive && ./autogen.sh && ./configure --prefix=/usr --disable-documentation > /dev/null && make && \
    make install && \
    #simple-obfs
    cd /tmp && curl -sSL ${OBFS_DL} | tar xz --strip 1 && \
    curl -sSL ${LIBCORK_DL} | tar xz --strip 1 -C libcork && \
    ./autogen.sh && ./configure --prefix=/usr --disable-documentation && make install && \
    #
    #cd /tmp && git clone ${PURPLEI2P_DL} && \
    #cd i2pd && make && \
    #
    cd /tmp && wget ${SSLH_DL} && tar -xzvf v1.20.tar.gz &&\
    cd sslh-1.20 && \
    #sed -i 's/^USELIBPCRE=.*/USELIBPCRE=1/' Makefile && \
    #make sslh && \
    make sslh-fork ENABLE_REGEX=1 USELIBPCRE=1 USELIBCONFIG=1 USELIBCAP=1 && \
    cp ./sslh-fork /usr/bin/sslh && \

    
    rm -rf /tmp/* && \
    apk --no-cache --purge del build-deps
    
    




