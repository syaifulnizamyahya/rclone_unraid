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
  
  
  sleep 5m &&

#Install dependancies
	installpkg /boot/rclone/install/man-1.6g-x86_64-3.txz
	installpkg /boot/rclone/install/infozip-6.0-x86_64-3.txz

#Download fresh version of rclone
	wget http://downloads.rclone.org/rclone-current-linux-amd64.zip -O //boot/rclone/install/rclone-current-linux-amd64.zip

#check if file downloaded
if [ -f "/boot/rclone/rclone-current-linux-amd64.zip" ]
then
    #remove existing rclone zip
	rm /boot/rclone/install/rclone-current-linux-amd64.zip
	rm -rf /boot/rclone/install/rclone-v*
	#move new rclone zip to install directory
	mv /boot/rclone/rclone-current-linux-amd64.zip /boot/rclone/install
	#unzip the rclone download into the install directory
	unzip /boot/rclone/install/rclone-current-linux-amd64.zip -d /boot/rclone/install/
fi

#Install rclone
#copy binary file
	cp /boot/rclone/install/rclone-v*/rclone /usr/sbin/
	chown root:root /usr/sbin/rclone
	chmod 755 /usr/sbin/rclone
#install manpage
	mkdir -p /usr/local/share/man/man1
	cp /boot/rclone/install/rclone-v*/rclone.1 /usr/local/share/man/man1/
	makewhatis

# copy config file to default location
cp /boot/rclone/install/.rclone.conf /root/

# set ssl certs
mkdir -p /etc/ssl/certs/
curl -o /etc/ssl/certs/ca-certificates.crt https://raw.githubusercontent.com/bagder/ca-bundle/master/ca-bundle.crt

#make any scripts executable
chmod u+x /boot/rclone/scripts/rcloneCopy.sh

# set cron job, this will run at 1min past midnight everynight
crontab -l | { cat; echo "1 0 * * * /boot/rclone/scripts/rcloneCopy.sh > /dev/null 2>&1"; } | crontab -
