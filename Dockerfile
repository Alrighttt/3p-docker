FROM ubuntu:20.04
ARG DEBIAN_FRONTEND=noninteractive

ENV BUILD_PACKAGES="build-essential libtool autotools-dev automake pkg-config libssl-dev libevent-dev bsdmainutils libboost-all-dev git curl"

RUN apt update && \
    #apt upgrade -y && \
    apt install -y $BUILD_PACKAGES

LABEL komodo_version="0.0605a"

RUN git clone https://github.com/emc2foundation/einsteinium --single-branch -b master

RUN cd einsteinium && \
    git checkout c329ae64397bea743054d06b779bb4cbfdcdd25f && \
    make -C ${PWD}/depends v=1 NO_PROTON=1 NO_QT=1 HOST=$(depends/config.guess) -j$(nproc --all) && \
    ./autogen.sh && \
    CXXFLAGS="-g0 -O2" \
    CONFIG_SITE="$PWD/depends/$(depends/config.guess)/share/config.site" ./configure --disable-tests --disable-bench --without-miniupnpc --enable-experimental-asm --with-gui=no --disable-bip70 && \
    make V=1 -j$(nproc --all) 


RUN apt remove --purge -y $BUILD_PACKAGES $(apt-mark showauto) && \
    rm -rf /var/lib/apt/lists/* 

RUN apt update && apt install -y libcurl3-gnutls-dev libgomp1 telnet curl

RUN useradd -u 3003 -m emc && \
    mkdir /home/emc/.einsteinium

COPY einsteinium.conf /home/emc/.einsteinium/einsteinium.conf

RUN chown -R emc:emc /home/emc/.einsteinium && \
    chmod 600 /home/emc/.einsteinium/einsteinium.conf

ENV PATH="/einsteinium/src/:${PATH}"
USER emc
WORKDIR /home/emc

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]