# Original works by stignz https://lime-technology.com/forum/index.php?topic=46663.0
# Installation
# make supporting directory structure on flash drive
	mkdir -p /boot/rclone
	mkdir -p /boot/rclone/install
	mkdir -p /boot/rclone/scripts
	mkdir -p /boot/rclone/logs

#download dependencies to /boot/rclone/install
	wget http://slackware.cs.utah.edu/pub/slackware/slackware64-14.2/slackware64/ap/man-1.6g-x86_64-3.txz -O //boot/rclone/install/man-1.6g-x86_64-3.txz
	wget http://slackware.cs.utah.edu/pub/slackware/slackware64-14.2/slackware64/a/infozip-6.0-x86_64-3.txz -O //boot/rclone/install/infozip-6.0-x86_64-3.txz
	curl -o /boot/rclone/install/ca-certificates.crt https://raw.githubusercontent.com/bagder/ca-bundle/master/ca-bundle.crt

#Install dependencies (skip infozip if you already have it installed)
	installpkg /boot/rclone/install/man-1.6g-x86_64-3.txz
	installpkg /boot/rclone/install/infozip-6.0-x86_64-3.txz
		
#Download rclone and unzip
	wget http://downloads.rclone.org/rclone-current-linux-amd64.zip -O //boot/rclone/install/rclone-current-linux-amd64.zip
	unzip /boot/rclone/install/rclone-current-linux-amd64.zip -d /boot/rclone/install/
	
#copy binary file
	cp /boot/rclone/install/rclone-v*/rclone /usr/sbin/
	chown root:root /usr/sbin/rclone
	chmod 755 /usr/sbin/rclone
#install manpage (makewhatis is also man-db on some Linux distributions)
	mkdir -p /usr/local/share/man/man1
	cp /boot/rclone/install/rclone-v*/rclone.1 /usr/local/share/man/man1/
	makewhatis
#copy ca-certificates
	mkdir -p /etc/ssl/certs/
	cp /boot/rclone/install/ca-certificates.crt /etc/ssl/certs/
  
