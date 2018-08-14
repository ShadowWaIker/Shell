#!/usr/bin/env python
#-*- coding: utf-8 -*-

import os
import time

file_dir = 'D:/MySQLBackup/'

def file_rm():
    f = list(os.listdir(file_dir))
    now_time = time.strftime('%Y-%m-%d_%H:%M:%S')
    with open(file_dir + 'del.log','a') as file_log:
        file_log.write("%s\n" % (now_time))
    flag = 1
    for i in f:
        if i[17:] == '.tar.gz':
            if flag == 7:
                os.rename(file_dir + i, file_dir + 'old_' + i)
                flag = 1
                continue
            print i
            os.remove(file_dir + i)
            with open(file_dir + 'del.log','a') as file_log:
                file_log.write("删除备份文件:%s \n" % (i))
            flag += 1

if __name__ == '__main__':
    file_rm()
