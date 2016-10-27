LOGFILE=/boot/rclone/logs/rclone-$(date "+%Y%m%d").log
echo rclone log $(date) $'\r'$'\r' >> $LOGFILE 2>&1

rclone copy /mnt/user/<ShareName>/<FolderName> <RemoteName>:<RemoteFolderName> >> $LOGFILE 2>&1
