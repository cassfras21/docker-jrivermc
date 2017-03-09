#!/bin/bash
set -e

# Run JRiver Media Center app container
if [ "$1" = '/usr/bin/supervisord' ]; then

	# Checking for dist and packages updates
	if [ "$update" = 'yes' ]; then
		apt-get --yes --force-yes update
		apt-get --yes --force-yes dist-upgrade
		apt-get --yes autoremove
	fi
	
	# Remove tmp files
	if [ -f /tmp/.X1-lock ]; then rm -f /tmp/.X1-lock; fi
	
	# Set the owner and permissions for JRiver runtime folder
	chown -R jriver:jriver /home/jriver/.jriver
	chmod -R 755 /home/jriver/.jriver
	
	# Set VNC password
	x11vnc -storepasswd $vncpass /home/jriver/.vnc/passwd
	chown jriver:jriver /home/jriver/.vnc/passwd
	chmod 700 /home/jriver/.vnc/passwd
fi

exec "$@"