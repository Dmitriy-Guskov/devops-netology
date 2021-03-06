# Домашнее задание к занятию "5.4. Практические навыки работы с Docker"

## Задача 1 

В данном задании вы научитесь изменять существующие Dockerfile, адаптируя их под нужный инфраструктурный стек.

Измените базовый образ предложенного Dockerfile на Arch Linux c сохранением его функциональности.

```text
FROM ubuntu:latest

RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:vincent-c/ponysay && \
    apt-get update
 
RUN apt-get install -y ponysay

ENTRYPOINT ["/usr/bin/ponysay"]
CMD ["Hey, netology”]
```

Для получения зачета, вам необходимо предоставить:
- Написанный вами Dockerfile
- Скриншот вывода командной строки после запуска контейнера из вашего базового образа
- Ссылку на образ в вашем хранилище docker-hub

Ответ:
dockerfile541:
```
FROM archlinux

RUN pacman -Sy --noconfirm &&\
    pacman -S pacman --noconfirm &&\
    pacman-db-upgrade &&\
    pacman -S --noconfirm ponysay   

ENTRYPOINT ["/usr/bin/ponysay"]
CMD ["Hey, netology"]
```

```
derpanter@Panters-MBP15 Docker % docker build -t hw541 -f dockerfile541 .            
Sending build context to Docker daemon   2.56kB
Step 1/4 : FROM archlinux
 ---> 1d6f90387c13
Step 2/4 : RUN pacman -Sy --noconfirm &&    pacman -S pacman --noconfirm &&    pacman-db-upgrade &&    pacman -S --noconfirm ponysay
 ---> Using cache
 ---> eb3e7ae7754e
Step 3/4 : ENTRYPOINT ["/usr/bin/ponysay"]
 ---> Using cache
 ---> aefff69a8cb9
Step 4/4 : CMD ["Hey, netology"]
 ---> Using cache
 ---> b03f825b5bcc
Successfully built b03f825b5bcc
Successfully tagged hw541:latest

Use 'docker scan' to run Snyk tests against images to find vulnerabilities and learn how to fix them
```



Ссылка на докер:
```
docker pull derpanter/devops-netology:1.0  
```
Скриншот - https://github.com/Dmitriy-Guskov/devops-netology/blob/main/hw541.png

Скриншот - https://github.com/Dmitriy-Guskov/devops-netology/blob/main/hw541_2.png



## Задача 2 

В данной задаче вы составите несколько разных Dockerfile для проекта Jenkins, опубликуем образ в `dockerhub.io` и посмотрим логи этих контейнеров.

- Составьте 2 Dockerfile:

    - Общие моменты:
        - Образ должен запускать [Jenkins server](https://www.jenkins.io/download/)
        
    - Спецификация первого образа:
        - Базовый образ - [amazoncorreto](https://hub.docker.com/_/amazoncorretto)
        - Присвоить образу тэг `ver1` 
    
    - Спецификация второго образа:
        - Базовый образ - [ubuntu:latest](https://hub.docker.com/_/ubuntu)
        - Присвоить образу тэг `ver2` 

- Соберите 2 образа по полученным Dockerfile
- Запустите и проверьте их работоспособность
- Опубликуйте образы в своём dockerhub.io хранилище

Для получения зачета, вам необходимо предоставить:
- Наполнения 2х Dockerfile из задания
- Скриншоты логов запущенных вами контейнеров (из командной строки)
- Скриншоты веб-интерфейса Jenkins запущенных вами контейнеров (достаточно 1 скриншота на контейнер)
- Ссылки на образы в вашем хранилище docker-hub

Ответ:

Докерфайлы
```
FROM amazoncorretto
RUN yum install wget -y
RUN rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
RUN wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
RUN amazon-linux-extras install epel -y
RUN yum update -y
RUN yum install jenkins java-1.8.0-openjdk-devel -y
CMD ["/bin/bash"]
```

UPD2:
```
FROM amazoncorretto
RUN yum update -y && \
    yum install wget -y && \
    wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo && \
        rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key && \
        yum upgrade -y
RUN amazon-linux-extras install epel -y
RUN yum install jenkins java-1.8.0-openjdk-devel -y
CMD java -jar /usr/lib/jenkins/jenkins.war
```



```
FROM ubuntu:latest
ENV TZ=Europe/Moscow
RUN apt-get update && apt-get install -yy tzdata
RUN cp /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt install wget -y
RUN apt-get install gnupg -y
RUN wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | apt-key add -y
RUN echo "deb https://pkg.jenkins.io/debian binary/" >> /etc/apt/sources.list
RUN apt-get update
RUN apt-get install jenkins -y
RUN apt install openjdk-11-jdk -y
RUN cd /usr/share/jenkins/
CMD ["/bin/bash"]
```

Команды сборки:
```
docker build -t derpanter/devops-netology:ver1 -f amazver1 .
```
```
docker build -t derpanter/devops-netology:ver2 -f ubunver2 .  
```

Команды запуска:
```
docker run -p 8085:8080 -p 50005:50000 -w /usr/lib/jenkins/ -i -t derpanter/devops-netology:ver1 java -jar jenkins.war
```
```
docker run -p 8082:8080 -p 50002:50000 -w /usr/share/jenkins/ -i -t derpanter/devops-netology:ver2 java -jar jenkins.war

```

Скриншоты в репозитории 
Amazon
https://github.com/Dmitriy-Guskov/devops-netology/blob/main/hw542_1.png
https://github.com/Dmitriy-Guskov/devops-netology/blob/main/hw542_2.png

Ubuntu
https://github.com/Dmitriy-Guskov/devops-netology/blob/main/hw542_3.png
https://github.com/Dmitriy-Guskov/devops-netology/blob/main/hw542_4.png




Ссылки на образы в хранилище:
```
docker pull derpanter/devops-netology:ver1
```
```
docker pull derpanter/devops-netology:ver2
```


UPD:
Докер файл1
```
FROM amazoncorretto
RUN yum update –y && 
yum install wget -y && 
wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo && 
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key && \
yum upgrade -y
RUN amazon-linux-extras install epel -y
RUN yum install jenkins java-1.8.0-openjdk-devel -y
CMD java -jar /usr/lib/jenkins/jenkins.war
```

Докер файл2
```
FROM ubuntu:latest
RUN apt-get update && 
apt-get install -y software-properties-common && 
apt-get install -y wget && 
apt-get install -y gnupg gnupg2 gnupg1 && 
wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | apt-key add -
RUN sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
RUN apt update
RUN apt install default-jre -y
RUN apt install jenkins -y
CMD java -jar /usr/share/jenkins/jenkins.war
```

Команды запуска:
```
docker run -p 8085:8080 -p 50005:50000 derpanter/devops-netology:ver1

docker run -p 8082:8080 -p 50002:50000 derpanter/devops-netology:ver2
```










## Задача 3 

В данном задании вы научитесь:
- объединять контейнеры в единую сеть
- исполнять команды "изнутри" контейнера

Для выполнения задания вам нужно:
- Написать Dockerfile: 
    - Использовать образ https://hub.docker.com/_/node как базовый
    - Установить необходимые зависимые библиотеки для запуска npm приложения https://github.com/simplicitesoftware/nodejs-demo
    - Выставить у приложения (и контейнера) порт 3000 для прослушки входящих запросов  
    - Соберите образ и запустите контейнер в фоновом режиме с публикацией порта

- Запустить второй контейнер из образа ubuntu:latest 
- Создайть `docker network` и добавьте в нее оба запущенных контейнера
- Используя `docker exec` запустить командную строку контейнера `ubuntu` в интерактивном режиме
- Используя утилиту `curl` вызвать путь `/` контейнера с npm приложением  

Для получения зачета, вам необходимо предоставить:
- Наполнение Dockerfile с npm приложением
- Скриншот вывода вызова команды списка docker сетей (docker network cli)
- Скриншот вызова утилиты curl с успешным ответом



Ответ:
Dockerfile node543
```
FROM node
RUN apt-get update
RUN git clone https://github.com/simplicitesoftware/nodejs-demo.git
WORKDIR /nodejs-demo/
RUN npm install -g nodemon
RUN npm install -g npm@7.5.1
RUN npm install
RUN sed -i "s/localhost/0.0.0.0/g" app.js
CMD npm start
```

Собираем:
docker build -t derpanter/devops-netology:ver3 -f node543 .

Создаем бридж:
docker network create bridge1


```
derpanter@Panters-MBP15 ~ % docker network ls
NETWORK ID     NAME      DRIVER    SCOPE
68225a0ce0af   bridge    bridge    local
20c9b3edd9cc   bridge1   bridge    local
7e87be8f2e14   host      host      local
86c888712c44   none      null      local
```
Скриншот - https://github.com/Dmitriy-Guskov/devops-netology/blob/main/hw543_1.png


Запускаем:
docker run -d -p 3000:3000 --net=bridge1 derpanter/devops-netology:ver3 npm start

подключаем убунту:
docker network connect bridge1 a192933d8f00

Смотрим выданные адреса:
```
derpanter@Panters-MBP15 ~ % docker network inspect bridge1             
[
    {
        "Name": "bridge1",
        "Id": "20c9b3edd9cc6bf07c8c4e4d82a2af4ff944abce97782eeb5a6cc5b03b4bb6c8",
        "Created": "2021-09-19T13:53:24.0202872Z",
        "Scope": "local",
        "Driver": "bridge",
        "EnableIPv6": false,
        "IPAM": {
            "Driver": "default",
            "Options": {},
            "Config": [
                {
                    "Subnet": "172.18.0.0/16",
                    "Gateway": "172.18.0.1"
                }
            ]
        },
        "Internal": false,
        "Attachable": false,
        "Ingress": false,
        "ConfigFrom": {
            "Network": ""
        },
        "ConfigOnly": false,
        "Containers": {
            "908155b4aff52c3f94093c823e401b0c45d605e15ae42c14273422bbc7799bc5": {
                "Name": "musing_bhaskara",
                "EndpointID": "77332ed674ee5c53d4fdd6ab6a263775b2e2efd09fd406a39251be96338bc074",
                "MacAddress": "02:42:ac:12:00:02",
                "IPv4Address": "172.18.0.2/16",
                "IPv6Address": ""
            },
            "a192933d8f0046de3c4efd91a8e8d4d08e4caaebbca54b90f59f9eea827a19a9": {
                "Name": "pensive_khorana",
                "EndpointID": "d5bbca46abaa68a8dc578102414cba7fa139b4fe67a3ab77c186586d4860ec63",
                "MacAddress": "02:42:ac:12:00:03",
                "IPv4Address": "172.18.0.3/16",
                "IPv6Address": ""
            }
        },
        "Options": {},
        "Labels": {}
    }
]

```

В Убунте выполняем:
```
root@a0cda571aca9:/# apt-get update  
root@a0cda571aca9:/# apt-get install curl wget
```

Запускаем curl:

```
root@a192933d8f00:/# curl 172.18.0.2:3000/
<!DOCTYPE html><html lang="en"><head><title>Node.js demo</title><meta charset="utf-8"><meta http-equiv="X-UA-Compatible" content="IE=edge"><meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=0"><link rel="shortcut icon" href="/favicon.png"><link rel="stylesheet" href="/index.css"><script type="text/javascript" src="/jquery.js"></script><script type="text/javascript">$(document).ready(function()

```
Скриншот - https://github.com/Dmitriy-Guskov/devops-netology/blob/main/hw543_2.png
```
docker pull derpanter/devops-netology:ver3
```


UPD:
Dockerfile node543_fix
```
FROM node
RUN apt-get update
RUN git clone https://github.com/simplicitesoftware/nodejs-demo.git
WORKDIR /nodejs-demo/
RUN sed -i s/localhost/0.0.0.0/g app.js
RUN npm install
CMD npm start
```

Собираем:
```
docker build -t derpanter/devops-netology:ver3_fix -f node543_fix .
```

Запускаем:
```
docker run -d -p 3000:3000 --net=bridge1 derpanter/devops-netology:ver3_fix
```

