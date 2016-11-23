#!/bin/bash
set -e

# Run JRiver Media Center app container
if [ "$1" = '/usr/bin/supervisord' ]; then

	# Checking for dist and packages updates
	if [ "$ENV_UPDATE" = 'yes' ]; then
		apt-get --yes --force-yes update
		apt-get --yes --force-yes dist-upgrade
		apt-get --yes autoremove
	fi
	
	# Remove tmp files
	if [ -f /tmp/.X1-lock ]; then rm /tmp/.X1-lock; fi
	
	# Remove JRiver thumbnails to avoid segfaults
	TPATH=/home/jriver/.jriver/Media\ Center\ 22/Thumbnails/
	if [ -d "$TPATH" ]; then rm -r "$TPATH"; fi
	
	# Set the owner and permissions for JRiver runtime folder
	chown -R jriver:jriver /home/jriver/.jriver
	chmod -R 755 /home/jriver/.jriver
	
	# Set VNC password
	su - jriver -c "x11vnc -storepasswd ${ENV_VNCPASS} ~/.vnc/passwd"
	
	# start framebuffer display server
	Xvfb :1 -extension GLX -screen 0 1024x768x24& DISPLAY=:1 /usr/bin/openbox-session&
	
	# X11 forwarding
	export DISPLAY=:1
fi

exec "$@"