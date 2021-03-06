FROM ubuntu:18.04
MAINTAINER Jackistang<tangjia.jackis@qq.com>

ENV HOMEPATH  /usr/home
WORKDIR $HOMEPATH

RUN apt update && apt upgrade -y
RUN apt install -y git libncurses5-dev python3 python3-pip qemu

RUN ln -s /usr/bin/python3 /usr/bin/python

RUN git clone -b 4.0.1 https://github.com.cnpmjs.org/SCons/scons.git
RUN cd scons && python3 setup.py install

RUN git clone -b v4.0.3 https://github.com.cnpmjs.org/RT-Thread/rt-thread.git

ADD gcc-arm-none-eabi-6_2-2016q4-20161216-linux.tar.bz2 /opt/
COPY rtconfig.py rt-thread/bsp/qemu-vexpress-a9/rtconfig.py
COPY menuconfig.py rt-thread/tools/menuconfig.py

RUN cd rt-thread/bsp/qemu-vexpress-a9 && pwd && scons --menuconfig
ENV PATH=/root/.env/tools/scripts:$PATH

CMD [ "/bin/bash" ]
