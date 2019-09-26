FROM ubuntu:18.10
MAINTAINER Walter A. Boring IV <waboring@hemna.com>

ENV VERSION=1.0.0
ENV HOME=/home/goes
ENV BRANCH="master"

ENV INSTALL=$HOME/install

RUN apt-get -y update
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get install -y apt-utils pkg-config
RUN apt-get install -y build-essential libusb-1.0 cmake
RUN apt-get install -y wget python3 python3-pip git-core
RUN apt-get install -y --no-install-recommends libopencv-dev
RUN apt-get install -y libproj-dev
#RUN apt-get install -y zlib1g-dev
#RUN apt-get install -y \
#  wget curl \
#  build-essential \
#  cmake \
#  git-core \
#  libopencv-dev \
#  zlib1g-dev


# Setup Timezone
# ENV TZ=US/Eastern
# RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
# RUN apt-get install -y tzdata
# RUN dpkg-reconfigure --frontend noninteractive tzdata

# Create directory to hold some of the install files.
RUN mkdir $HOME && chmod 777 $HOME && cd $HOME && mkdir install

#RUN cd $INSTALL && wget https://bootstrap.pypa.io/get-pip.py && python3 get-pip.py
RUN pip3 install -U pip setuptools wheel
#RUN pip3 install pyephem paho-mqtt python-cjson

# install librtlsdr from source
RUN cd $INSTALL && git clone https://github.com/steve-m/librtlsdr
RUN cd $INSTALL/librtlsdr && mkdir build && cd build && cmake ../ -DINSTALL_UDEV_RULES=ON
RUN cd $INSTALL/librtlsdr/build && make && make install

RUN cd $INSTALL && git clone git://git.osmocom.org/rtl-sdr.git
RUN cd $INSTALL/rtl-sdr && mkdir build
RUN cd $INSTALL/rtl-sdr/build && cmake ../ -DINSTALL_UDEV_RULES=ON
RUN cd $INSTALL/rtl-sdr/build && make && make install
RUN ldconfig

# install goestools from source
RUN cd $INSTALL && git clone -b $BRANCH --recursive https://github.com/pietern/goestools
RUN cd $INSTALL/goestools/share/wxstar && git clone https://github.com/hdoverobinson/wx-star_false-color
RUN cd $INSTALL/goestools && mkdir build
RUN cd $INSTALL/goestools/build && cmake ..
RUN cd $INSTALL/goestools/build && make && make install

# add all confs and extras to the install
# based on CONF env, copy the dirs to the install using CMD cp

# override this to run another configuration
ENV CONF default

ADD conf/goesrecv.conf $HOME/
ADD conf/goesproc.conf $HOME/
ADD bin/run.sh $HOME/
RUN chmod 755 $HOME/run.sh

# Syslog to split out weewx logs to it's own log file
#RUN ln -s $HOME/util/rsyslog.d/weewx.conf /etc/rsyslog.d/10-weewx.conf
RUN mkdir $HOME/logs

WORKDIR $HOME
EXPOSE 80

CMD $HOME/run.sh
