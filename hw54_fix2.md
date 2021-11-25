dockerfile

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

Команды сборки:
```
docker build -t derpanter/devops-netology:ver1 -f amazver1 .
```

Команды запуска:
```
docker run -p 8085:8080 -p 50005:50000 -w /usr/lib/jenkins/ -i -t derpanter/devops-netology:ver1 java -jar jenkins.war
```

