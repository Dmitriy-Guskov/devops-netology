## Домашнее задание к занятию "4.2. Использование Python для решения типовых DevOps задач"
Обязательные задания
1.	Есть скрипт:
#!/usr/bin/env python3
a = 1
b = '2'
c = a + b
o	Какое значение будет присвоено переменной c?
o	Как получить для переменной c значение 12?
o	Как получить для переменной c значение 3?

Ответ:
-	Будет ошибка, т.к. разные типы сложить не получается
-	Чтобы получить с = 12 нужно переменную «а» сделать типа str: c=str(a)+b
-	Чтобы получить с = 3 нужно переменную «b» сделать типа int: c=a+int(b)


2.	Мы устроились на работу в компанию, где раньше уже был DevOps Engineer. Он написал скрипт, позволяющий узнать, какие файлы модифицированы в репозитории, относительно локальных изменений. Этим скриптом недовольно начальство, потому что в его выводе есть не все изменённые файлы, а также непонятен полный путь к директории, где они находятся. Как можно доработать скрипт ниже, чтобы он исполнял требования вашего руководителя?

```
#!/usr/bin/env python3

import os

bash_command = ["cd ~/netology/sysadm-homeworks", "git status"]
result_os = os.popen(' && '.join(bash_command)).read()
is_change = False
for result in result_os.split('\n'):
    if result.find('modified') != -1:
        prepare_result = result.replace('\tmodified:   ', '')
        print(prepare_result)
        break
```

Решение:

```
#!/usr/bin/env python3

import os
path='~/devops-netology'

bash_command = ["cd " +path, "git status"]
result_os = os.popen(' && '.join(bash_command)).read()
# лишнее
# is_change = False
for result in result_os.split('\n'):
    if result.find('modified') != -1:
        prepare_result = result.replace('\tmodified:   ', '')
        separator='/'
        out=path+separator+prepare_result
        print(out)
# лишнее
#       break
```
Вывод:
```
derpanter@Panters-MBP15 ~ % python3 hw42.py
~/devops-netology/README.md
~/devops-netology/has_been_moved.txt
```


3.	Доработать скрипт выше так, чтобы он мог проверять не только локальный репозиторий в текущей директории, а также умел воспринимать путь к репозиторию, который мы передаём как входной параметр. Мы точно знаем, что начальство коварное и будет проверять работу этого скрипта в директориях, которые не являются локальными репозиториями.

Решение:
```
!/usr/bin/env python3

import os
import sys

#Проверяем входящий параметр, если нет - берём текущую папку
path = os.getcwd()
if len(sys.argv)>=2:
  path = sys.argv[1]

bash_command = ["cd " +path, "git status"]
result_os = os.popen(' && '.join(bash_command)).read()
for result in result_os.split('\n'):
    if result.find('modified') != -1:
        prepare_result = result.replace('\tmodified:   ', '')
        separator='/'
        out=path+separator+prepare_result
        print(out)
```

Вывод:
```
derpanter@Panters-MBP15 ~ % python3 hw42.py devops-netology 
devops-netology/README.md
devops-netology/has_been_moved.txt
```


4.	Наша команда разрабатывает несколько веб-сервисов, доступных по http. Мы точно знаем, что на их стенде нет никакой балансировки, кластеризации, за DNS прячется конкретный IP сервера, где установлен сервис. Проблема в том, что отдел, занимающийся нашей инфраструктурой очень часто меняет нам сервера, поэтому IP меняются примерно раз в неделю, при этом сервисы сохраняют за собой DNS имена. Это бы совсем никого не беспокоило, если бы несколько раз сервера не уезжали в такой сегмент сети нашей компании, который недоступен для разработчиков. Мы хотим написать скрипт, который опрашивает веб-сервисы, получает их IP, выводит информацию в стандартный вывод в виде: <URL сервиса> - <его IP>. Также, должна быть реализована возможность проверки текущего IP сервиса c его IP из предыдущей проверки. Если проверка будет провалена - оповестить об этом в стандартный вывод сообщением: [ERROR] <URL сервиса> IP mismatch: <старый IP> <Новый IP>. Будем считать, что наша разработка реализовала сервисы: drive.google.com, mail.google.com, google.com.

Решение:

```
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
```


Использовал локальный ДНС, во время работы скрипта изменил адрес, очистил кэш ДНС на клиенте. В результате получили:
```
derpanter@Panters-MBP15 devops-netology % python3 hw424.py
2021-07-27 20:38:13 [ERROR] netology.loc IP mistmatch: 333.333.333.333 10.0.0.111
2021-07-27 20:38:13 [ERROR] devops.loc IP mistmatch: 444.444.444.444 10.0.0.132
2021-07-27 20:38:13 [ERROR] google.com IP mistmatch: 555.555.555.555 64.233.165.113
2021-07-27 20:39:03 [ERROR] devops.loc IP mistmatch: 10.0.0.132 10.0.0.102
2021-07-27 20:39:03 [ERROR] google.com IP mistmatch: 64.233.165.113 64.233.164.113
^CTraceback (most recent call last):
  File "hw424.py", line 20, in <module>
    time.sleep(5)
KeyboardInterrupt
```

