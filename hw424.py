#!/usr/bin/env python3

import socket
import datetime
import time

i = 1
srvlist = {'netology.loc':'333.333.333.333', 'devops.loc':'444.444.444.444', 'google.com':'555.555.555.555'}

while 1 == 1:
  for host in srvlist:
    ip = socket.gethostbyname(host)
    if ip != srvlist[host]:
        print(str(datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")) +' [ERROR] ' + str(host) +' IP mistmatch: '+srvlist[host]+' '+ip)
        srvlist[host] = ip

  i+=1
# print(i)
  time.sleep(5)
