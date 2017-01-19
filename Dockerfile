FROM debian:wheezy-slim
ENV DEPENDENCIES="libcrypto++9 libpng12-0 libupnp6 libwxbase2.8-0"

# Add bin file
ADD bin/amule-adunanza-daemon_2012.1+2.3.1-0wheezy1_amd64.deb /setup/bin/

RUN apt-get -y update && apt-get install -y $DEPENDENCIES && \
    apt-get clean

RUN dpkg -i /setup/bin/amule-adunanza-daemon_2012.1+2.3.1-0wheezy1_amd64.deb
EXPOSE 4711/tcp 4712/tcp 4672/udp 4665/udp 4662/tcp 4661/tcp 

# Define default command
CMD ["/bin/bash"]
