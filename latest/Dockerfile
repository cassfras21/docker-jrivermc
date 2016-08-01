FROM debian:jessie

# Install wget
RUN apt-get update \
 && apt-get install -y wget \
 && rm -rf /var/lib/apt/lists/*

# Add JRiver packages to apt-get
RUN wget -q "http://dist.jriver.com/mediacenter@jriver.com.gpg.key" -O- | apt-key add - \
 && wget http://dist.jriver.com/latest/mediacenter/mediacenter21jessie.list -O \
	/etc/apt/sources.list.d/mediacenter21.list

# Install JRiver and VNC
RUN apt-get update && apt-get install -y \
	mediacenter21 \
	openbox \
	supervisor \
	xvfb \
	x11vnc \
 && rm -rf /var/lib/apt/lists/*

# Add jriver user and group
RUN groupadd -r jriver \
 && useradd -r -ms /bin/bash -g jriver jriver

# Set up JRiver
RUN	mkdir /home/jriver/.jriver \
 && chown jriver:jriver /home/jriver/.jriver
VOLUME ["/home/jriver/.jriver"]

# Set up VNC
ENV ENV_VNCPASS jriver
RUN	mkdir /home/jriver/.vnc \
 && chown jriver:jriver /home/jriver/.vnc

# Set up supervisord
COPY supervisord.conf /etc/supervisor/conf.d/
RUN chmod 700 /etc/supervisor/conf.d/supervisord.conf

# Set up entrypoint
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 5900 52100 52101 52199 1900/udp
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]