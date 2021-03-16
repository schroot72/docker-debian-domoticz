#
# Each instruction in this file generates a new layer that gets pushed to your local image cache
#
 
#
# Lines preceeded by # are regarded as comments and ignored
#
 
#
# The line below states we will base our new image on the Latest Official Ubuntu 
FROM debian:latest
 #
# Identify the maintainer of an image
LABEL maintainer="alwin@schrooten.com"
 
RUN apt-get update && apt-get upgrade -y && \
apt-get install -y --no-install-recommends --fix-missing git libssl1.1 libssl-dev  build-essential cmake  libboost-dev  libboost-thread-dev  libboost-system-dev  libboost-date-time-dev  libsqlite3-0 libsqlite3-dev  wget curl libcurl4 libcurl4-openssl-dev libusb-0.1-4 libusb-dev  zlib1g-dev  libudev-dev linux-headers-amd64  python3-dev  ca-certificates liblua5.3-0 liblua5.3-dev libcereal-dev systemd python3-pip nano && \
#
cd /home && wget https://github.com/Kitware/CMake/releases/download/v3.19.2/cmake-3.19.2-Linux-x86_64.sh && mkdir /opt/cmake && sh cmake-3.19.2-Linux-x86_64.sh --prefix=/opt/cmake --exclude-subdir --skip-license && ln -s /opt/cmake/bin/cmake /usr/local/bin/cmake && \
#
git clone --depth 2 https://github.com/OpenZWave/open-zwave.git /src/open-zwave && cd /src/open-zwave && make && ln -s /src/open-zwave /src/open-zwave-read-only && \
git clone --depth 2 https://github.com/domoticz/domoticz.git /src/domoticz && cd /src/domoticz && git fetch --unshallow && cmake -DCMAKE_BUILD_TYPE=Release . && make && \
cd / && wget https://www.schrooten.com/docker/run.sh && \
chmod +x /run.sh && \
#
curl -sL https://deb.nodesource.com/setup_15.x | bash - && \
apt-get install -y nodejs && \
npm install -g mqtt url request && \
apt-get install -y mosquitto mosquitto-clients && \
npm install -g --unsafe-perm node-red && \
#

#
# Expose ports
EXPOSE 8080 1443 1883 6144

 
#
# Last is the actual command to start the run script to create the config folder and start domoticz
CMD ["/bin/bash /run.sh"]