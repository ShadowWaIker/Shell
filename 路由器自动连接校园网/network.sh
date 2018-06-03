#获取某url的连接情况
status=$(wget -s baidu.com 2>&1)
#需要认证时返回的连接情况
auth="Connecting to 1.1.1.3 (1.1.1.3:80)"
#判断是否存在认证跳转
result=$(echo $status | grep "${auth}")

if [ "$result" != "" ]
then
	wget --post-data="opr=pwdLogin&userName=用户名&pwd=密码&rememberPwd=1"  http://认证服务器/ac_portal/login.php  -O ./login_status.json -q
	echo "" >>./network.log
	date +%F_%T >>/root/network.log
	echo "账号："$(jsonfilter -i ./login_status.json -e "@.userName") >>./network.log
	echo "状态："$(jsonfilter -i ./login_status.json -e "@.msg") >>./network.log
	#echo "connect success!" >>/root/network.log
	#echo "need connect!"
else
	#echo "has been connected!"
	exit 0
fi
