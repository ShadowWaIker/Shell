#/usr/bin/sh
if [ -f /mnt/upload_image/check ]; then
	mv /var/www/html/api/upload_image/* /mnt/upload_image/
	mv /var/www/html/api/upload_image_thumbnail/* /mnt/upload_image/thumbnail/
	echo "synchronized!";
else
	#重新挂载磁盘
	mount -t cifs //file服务器/yxxy /mnt/upload_image -o username=用户名,password=密码
	echo "remounted!";
fi