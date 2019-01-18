#!/bin/sh

#当前日期
echo -e "\n\n"
echo $( date "+%Y-%m-%d_%H%M ")

#判读挂载点是否存在
if [ ! -d "/backup/" ];then
	echo -e "\033[31m 挂载点不存在，新建挂载点。 \033[0m"
	mkdir /backup
else
	echo -e "\033[32m 挂载点已存在。 \033[0m"
fi

#判读是否挂载成功
if [ ! -d "/backup/connection.flag/" ];then
	echo -e "\033[31m 未挂载服务端MySQLBackup目录。 \033[0m"
	count=1
	while [ $count -le 5 -a ! -d "/backup/connection.flag/" ]; do
		echo " 正在尝试第${count}次挂载。"
		count=$((count + 1))
		mount -t cifs //SMB存储IP地址/MySQLBackup /backup -o username=SMB存储用户名,password=SMB存储密码
		if [ -d "/backup/connection.flag/" ];then
			echo -e "\033[32m 成功挂载服务端MySQLBackup目录，开始备份。 \033[0m"
		fi
	done
else
	echo -e "\033[32m 已挂载服务端MySQLBackup目录，开始备份。 \033[0m"
fi

if [ -d "/backup/connection.flag/" ];then
	#对数据库进行备份
	echo -e "\033[32m 开始导出数据库。 \033[0m"
	mysqldump --all-databases > /root/databases.sql
	echo -e "\033[32m 导出结束，开始压缩文件。 \033[0m"
	cd /root
	tar -zcvf databases.tar.gz databases.sql
	echo -e "\033[32m 压缩结束，开始传输文件。 \033[0m"
	cp /root/databases.tar.gz /backup/$( date "+%Y-%m-%d_%H%M%S").tar.gz
	#卸载挂载点
	echo -e "\033[32m 文件传输结束，开始清理临时文件并卸载服务端MySQLBackup目录。 \033[0m"
	rm -rf /root/databases.sql
	rm -rf /root/databases.tar.gz
	umount /backup
	echo -e "\033[32m 备份结束。 \033[0m"
else
	echo -e "\033[31m 备份失败，未挂载服务端MySQLBackup目录。 \033[0m"
fi
