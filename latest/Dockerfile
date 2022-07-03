# Pull base image.
FROM jlesage/baseimage-gui:alpine-3.6

# Copy the start script.
COPY startapp.sh /startapp.sh

# Set the name of the application.
ENV APP_NAME="JRiverMediaCenter22"
ENV VNC_PASSWORD jriver

# Install wget
RUN apt-get update \
	&& apt-get install -y wget \

	# Add JRiver packages to apt-get
	&& wget -q "http://dist.jriver.com/mediacenter@jriver.com.gpg.key" -O- | apt-key add - \
	&& wget http://dist.jriver.com/latest/mediacenter/mediacenter22jessie.list -O \
	/etc/apt/sources.list.d/mediacenter22.list \

	# Install JRiver
	&& apt-get install -y \
	mediacenter22 \
	&& rm -rf /var/lib/apt/lists/*

# Add user and group
RUN groupadd -r jriver \
	&& useradd -r -ms /bin/bash -g jriver jriver \

	# Set up JRiver
	&&	mkdir /home/jriver/.jriver \
	&& chown jriver:jriver /home/jriver/.jriver \

	# Set the owner and permissions for JRiver runtime folder
	&& chown -R jriver:jriver /home/jriver/.jriver \
	&& chmod -R 755 /home/jriver/.jriver

VOLUME ["/home/jriver/.jriver"]

EXPOSE 5800 5900 52100 52101 52199 1900/udp