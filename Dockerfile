FROM debian:bookworm-slim

#Install Prereqs
RUN dpkg --add-architecture armhf \
&&  apt-get update -y \
&&  apt-get upgrade -y \
&&  apt-get install -y wget gpg git tar build-essential cmake python3 libc6:armhf

#Build box64 with box32
RUN git clone https://github.com/ptitSeb/box64 \
&&  cd box64 \
&&  mkdir build; cd build; cmake .. -D RPI5ARM64=1 -D ARM_DYNAREC=ON -D CMAKE_BUILD_TYPE=RelWithDebInfo -D BOX32=ON -D BOX32_BINFMT=ON \
&&  make -j4 \
&&  make install

# Install Steam
RUN mkdir   /steamcmd \
&&  cd      /steamcmd \
&&  wget -qO- "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar zxvf -

# Install required library and scripts
COPY ./add /scripts/
RUN chmod +x /scripts/valheim.sh

# Setting Environmental Variables
ENV SERVER_NAME=Raspiheim \
    SERVER_PASS=Raspipass \
    WORLD_NAME=Raspiworld \
    SAVE_DIR=/data \
    PUBLIC=disabled \
    UPDATE=enabled \
    SAVE_INTERVAL=1800 \
    CROSSPLAY=enabled

EXPOSE 2456/udp 2457/udp

ENTRYPOINT ["/scripts/valheim.sh"]