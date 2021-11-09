#
# We will base our new image on the Latest Official Debian
#
FROM debian:10.9
#
# set viarables
#
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Amsterdam
ENV Version=1.2
#
# Identify the maintainer of an image
#
LABEL maintainer="alwin@schrooten.com"
#
# Update and install required packages for domoticz
#
RUN apt-get update && apt-get upgrade -y && \
apt-get install -y --no-install-recommends --fix-missing git libssl1.1 libssl-dev  build-essential cmake  libboost-dev  libboost-thread-dev  libboost-system-dev  libboost-date-time-dev  libsqlite3-0 libsqlite3-dev  wget curl libcurl4 libcurl4-openssl-dev libusb-0.1-4 libusb-dev  zlib1g-dev  libudev-dev linux-headers-amd64  python3-dev  ca-certificates liblua5.3-0 liblua5.3-dev libcereal-dev systemd python3-pip nano && \
#
# install latest CMake for Domoticz
#
cd /home && wget https://github.com/Kitware/CMake/releases/download/v3.19.2/cmake-3.19.2-Linux-x86_64.sh && mkdir /opt/cmake && sh cmake-3.19.2-Linux-x86_64.sh --prefix=/opt/cmake --exclude-subdir --skip-license && ln -s /opt/cmake/bin/cmake /usr/local/bin/cmake && \
#
# Download domoticz and OpenZWave and compile them
#
git clone --depth 2 https://github.com/OpenZWave/open-zwave.git /src/open-zwave && cd /src/open-zwave && make && ln -s /src/open-zwave /src/open-zwave-read-only && \
git clone --depth 2 https://github.com/domoticz/domoticz.git /src/domoticz && cd /src/domoticz && git fetch --unshallow && cmake -DCMAKE_BUILD_TYPE=Release . && make && \
#
# download run.sh file and make it executable
#
cd / && wget https://raw.githubusercontent.com/schroot72/docker-debian-domoticz/main/run.sh && \
chmod +x /run.sh && \
#
# install nodejs and mqtt
#
curl -sL https://deb.nodesource.com/setup_17.x | bash - && \
apt-get install -y nodejs && \
npm install -g mqtt url request && \
#
# install mosquitto
#
wget http://repo.mosquitto.org/debian/mosquitto-repo.gpg.key -P / && \
apt-key add /mosquitto-repo.gpg.key && \
rm /mosquitto-repo.gpg.key && \
wget http://repo.mosquitto.org/debian/mosquitto-buster.list -P /etc/apt/sources.list.d/ && \
apt-get update && \
apt-get install -y mosquitto mosquitto-clients && \
mkdir /var/run/mosquitto/ && chown mosquitto:mosquitto /var/run/mosquitto && \
echo "listener 1883" >> /etc/mosquitto/mosquitto.conf && \
echo "allow_anonymous true" >> /etc/mosquitto/mosquitto.conf && \
#
#Install Node-red and update npm
#
npm install -g --unsafe-perm node-red && \
npm install -g npm@8.1.3 && \
mkdir /var/run/mosquitto/ && chown mosquitto:mosquitto /var/run/mosquitto && \
#
# Install Tuya Internet Plugin
#
pip3 install tuyaha requests && \
git clone https://github.com/Xenomes/Domoticz-TUYA-Plugin.git /src/domoticz/plugins/Domoticz-TUYA-Plugin && \
#
# Istall DeCONZ Zigbee plugin
#
git clone https://github.com/Smanar/Domoticz-deCONZ.git /src/domoticz/plugins/Domoticz-deCONZ && \
#
# Set version on disk for future plugin updates through run.sh scripts
#
echo "version 1.2" > /src/docker-debian-domoticz.txt
#
#
# Expose ports
EXPOSE 8080 1883 6144

 
#
# Last is the actual command to start the run script to create the config folder and start domoticz
CMD ["/bin/bash /run.sh"]
