#!/usr/bin/env python
#-*-coding:utf-8-*-
# 20171227 TraceWalker
import paramiko 
port = 22
username = "root"
password = "qq87593883"
for ip in range(22,28+1): 
    hostname = '192.168.1.'+str(ip)
    print "##########################",hostname,"########################"
    s = paramiko.SSHClient() 
    s.set_missing_host_key_policy(paramiko.AutoAddPolicy()) 
    s.connect(hostname, port, username, password)
    stdin,stdout,sterr = s.exec_command("ls;reboot") 
    print stdout.read()
    s.close()
print(u"按下任意键继续...")
input()
