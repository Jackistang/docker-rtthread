FROM ubuntu:18.04
MAINTAINER Jackistang<tangjia.jackis@qq.com>

ENV HOMEPATH  /usr/home
WORKDIR $HOMEPATH

RUN apt update && apt upgrade -y
RUN apt install -y git libncurses5-dev python3 python3-pip qemu

RUN ln -s /usr/bin/python3 /usr/bin/python

RUN cd $HOMEPATH
RUN git clone -b 4.0.1 https://github.com.cnpmjs.org/SCons/scons.git
RUN cd scons && python3 setup.py install

RUN cd $HOMEPATH
RUN git clone -b v4.0.3 https://github.com.cnpmjs.org/RT-Thread/rt-thread.git

ADD gcc-arm-none-eabi-6_2-2016q4-20161216-linux.tar.bz2 /opt/
COPY rtconfig.py rtthread/bsp/qemu-vexpress-a9/rtconfig.py

RUN scons --menuconfig

CMD /home/.env/env.sh
CMD echo "----end----"
CMD /bin/bash