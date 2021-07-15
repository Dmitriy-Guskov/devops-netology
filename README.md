## Домашнее задание к занятию "4.1. Командная оболочка Bash: Практические навыки"

Обязательные задания
1.	Есть скрипт:
a=1
b=2
c=a+b
d=$a+$b
e=$(($a+$b))
o	Какие значения переменным c,d,e будут присвоены?
o	Почему?
```
bash-3.2$ echo $c && echo $d && echo $e
a+b
1+2
3
```
c=a+b – указан текст, а не переменные
d=1+3 – вывели значение переменных, вычисления не произошло, т.к. по умолчанию это строки
e=3 – скобки сказали башу выполнить арифметическую операцию со значениями переменных


2.	На нашем локальном сервере упал сервис и мы написали скрипт, который постоянно проверяет его доступность, записывая дату проверок до тех пор, пока сервис не станет доступным. В скрипте допущена ошибка, из-за которой выполнение не может завершиться, при этом место на Жёстком Диске постоянно уменьшается. Что необходимо сделать, чтобы его исправить:
while ((1==1)
do
curl https://localhost:4757
if (($? != 0))
then
date >> curl.log
fi
done

- не хватает закрывающейся скобки - while ((1==1))
- нужно уменьшить количество проверок, например добавить sleep 10 для задания интервала проверки
- чтобы выйти из цикла нужно добавить «проверку успешности» - else break 2

Итого:
```
while ((1==1))
do
curl https://localhost:4757
if (($? != 0))
then
date >> curl.log
else
break 2
fi
sleep 10
done
```



3.	Необходимо написать скрипт, который проверяет доступность трёх IP: 192.168.0.1, 173.194.222.113, 87.250.250.242 по 80 порту и записывает результат в файл log. Проверять доступность необходимо пять раз для каждого узла.
```
vagrant@vagrant:~$ cat chkhosts.log 
Thu Jul 15 19:36:27 UTC 2021 192.168.0.1 status=0
Thu Jul 15 19:36:27 UTC 2021 173.194.222.113 status=0
Thu Jul 15 19:36:27 UTC 2021 87.250.250.242 status=0
Thu Jul 15 19:36:28 UTC 2021 192.168.0.1 status=0
Thu Jul 15 19:36:28 UTC 2021 173.194.222.113 status=0
Thu Jul 15 19:36:28 UTC 2021 87.250.250.242 status=0
Thu Jul 15 19:36:29 UTC 2021 192.168.0.1 status=0
Thu Jul 15 19:36:29 UTC 2021 173.194.222.113 status=0
Thu Jul 15 19:36:29 UTC 2021 87.250.250.242 status=0
Thu Jul 15 19:36:30 UTC 2021 192.168.0.1 status=0
Thu Jul 15 19:36:30 UTC 2021 173.194.222.113 status=0
Thu Jul 15 19:36:30 UTC 2021 87.250.250.242 status=0
Thu Jul 15 19:36:31 UTC 2021 192.168.0.1 status=0
Thu Jul 15 19:36:32 UTC 2021 173.194.222.113 status=0
Thu Jul 15 19:36:32 UTC 2021 87.250.250.242 status=0

vagrant@vagrant:~$ cat chkhosts.sh 
#!/bin/bash
srv=(192.168.0.1 173.194.222.113 87.250.250.242)

if [ -f chkhosts.log ]
then
	echo "Removing old logg..."
	rm chkhosts.log
else
	echo "No log file, continue..."
fi

for i in {1..5}
do
    for s in ${srv[@]}
    do
	curl -Is --connect-timeout 1 $s:80
	a=$(date)
        echo $a $s status=$? >>chkhosts.log
    done
done
vagrant@vagrant:~$ 
```




4.	Необходимо дописать скрипт из предыдущего задания так, чтобы он выполнялся до тех пор, пока один из узлов не окажется недоступным. Если любой из узлов недоступен - IP этого узла пишется в файл error, скрипт прерывается

```
vagrant@vagrant:~$ cat chkhosts4.log 
Thu Jul 15 20:48:22 UTC 2021 192.168.0.1  is not reachable
vagrant@vagrant:~$ cat chkhosts4.sh 
#!/bin/bash
srv=(192.168.0.1 173.194.222.113 87.250.250.242)

if [ -f chkhosts4.log ]
then
	echo "Removing old log..."
	rm chkhosts4.log
else
	echo "No log file, continue..."
fi

while ((1 == 1))
do
    for s in ${srv[@]}
    do
	curl -Is --connect-timeout 2 $s:80
	if (($? !=0))
	then
		a=$(date)
	        echo $a $s " is not reachable" >>chkhosts4.log
		break 3
	fi
    done
done
```

