Домашнее задание к занятию 3.3.
Операционные системы, лекция 1

1. Какой системный вызов делает команда cd? В прошлом ДЗ мы выяснили, что cd не является самостоятельной программой, это shell builtin, поэтому запустить strace непосредственно на cd не получится. Тем не менее, вы можете запустить strace на /bin/bash -c 'cd /tmp'. В этом случае вы увидите полный список системных вызовов, которые делает сам bashпри старте. Вам нужно найти тот единственный, который относится именно к cd.

strace /bin/bash -c 'cd /tmp'

stat("/tmp", {st_mode=S_IFDIR|S_ISVTX|0777, st_size=4096, ...}) = 0
chdir("/tmp")                           = 0



2. Попробуйте использовать команду file на объекты разных типов на файловой системе. Например:
vagrant@netology1:~$ file /dev/tty
/dev/tty: character special (5/0)
vagrant@netology1:~$ file /dev/sda
/dev/sda: block special (8/0)
vagrant@netology1:~$ file /bin/bash
/bin/bash: ELF 64-bit LSB shared object, x86-64
Используя strace выясните, где находится база данных file на основании которой она делает свои догадки.

strace file -c '/bin/bash'

нашел 
openat(AT_FDCWD, "/usr/share/misc/magic.mgc", O_RDONLY) = 3

смотрим что в каталоге
ls -la /usr/share/misc/

Оп, а это сслыка! 

magic.mgc -> ../../lib/file/magic.mgc



3. Предположим, приложение пишет лог в текстовый файл. Этот файл оказался удален (deleted в lsof), однако возможности сигналом сказать приложению переоткрыть файлы или просто перезапустить приложение – нет. Так как приложение продолжает писать в удаленный файл, место на диске постепенно заканчивается. Основываясь на знаниях о перенаправлении потоков предложите способ обнуления открытого удаленного файла (чтобы освободить место на файловой системе).

Отправим в никуда:
cat /dev/null > somefile.log

upd:
Откроем чем-нибудь файл, чтобы заблокировать его, например, vim
Далее 
vagrant@vagrant:~$ ls
1.log  echo  file.iso  file.txt  test  ttys001
vagrant@vagrant:~$ rm -f file.iso 
vagrant@vagrant:~$ lsof |grep deleted
vim       1198                       vagrant    3r      REG              253,0 1073741824    2883611 /home/vagrant/file.iso (deleted)
vagrant@vagrant:~$ ls -la /proc/1198/fd
total 0
dr-x------ 2 vagrant vagrant  0 Jun 11 14:51 .
dr-xr-xr-x 9 vagrant vagrant  0 Jun 11 14:51 ..
lrwx------ 1 vagrant vagrant 64 Jun 11 14:52 0 -> /dev/pts/0
lrwx------ 1 vagrant vagrant 64 Jun 11 14:52 1 -> /dev/pts/0
lrwx------ 1 vagrant vagrant 64 Jun 11 14:52 2 -> /dev/pts/0
lr-x------ 1 vagrant vagrant 64 Jun 11 14:51 3 -> '/home/vagrant/file.iso (deleted)'
lrwx------ 1 vagrant vagrant 64 Jun 11 14:52 4 -> /home/vagrant/.file.iso.swp
vagrant@vagrant:~$ cat /dev/null >/proc/1198/fd/3

в vim видим событие "file.iso" [noeol] 1L, 659619840CKilled





4. Занимают ли зомби-процессы какие-то ресурсы в ОС (CPU, RAM, IO)?

Зомби занимают место в таблице процессов, которая ограничена для каждого пользователя и для системы в целом.

5. В iovisor BCC есть утилита opensnoop:
root@vagrant:~# dpkg -L bpfcc-tools | grep sbin/opensnoop
/usr/sbin/opensnoop-bpfcc
На какие файлы вы увидели вызовы группы open за первую секунду работы утилиты? Воспользуйтесь пакетом bpfcc-toolsдля Ubuntu 20.04. Дополнительные сведения по установке.

vagrant@vagrant:~$ sudo opensnoop-bpfcc -d 5

PID    COMM               FD ERR PATH
769    vminfo              6   0 /var/run/utmp
573    dbus-daemon        -1   2 /usr/local/share/dbus-1/system-services
573    dbus-daemon        18   0 /usr/share/dbus-1/system-services
573    dbus-daemon        -1   2 /lib/dbus-1/system-services
573    dbus-daemon        18   0 /var/lib/snapd/dbus-1/system-services/
769    vminfo              6   0 /var/run/utmp
573    dbus-daemon        -1   2 /usr/local/share/dbus-1/system-services
573    dbus-daemon        18   0 /usr/share/dbus-1/system-services
573    dbus-daemon        -1   2 /lib/dbus-1/system-services
573    dbus-daemon        18   0 /var/lib/snapd/dbus-1/system-services/

Поймались vminfo и dbus-daemon


6. Какой системный вызов использует uname -a? Приведите цитату из man по этому системному вызову, где описывается альтернативное местоположение в /proc, где можно узнать версию ядра и релиз ОС.

Запускаем
sudo opensnoop-bpfcc -d 50

рядом в консоли открываем uname -a

получаем:
2010   uname               3   0 /etc/ld.so.cache
2010   uname               3   0 /lib/x86_64-linux-gnu/libc.so.6
2010   uname               3   0 /usr/lib/locale/locale-archive
2010   uname               3   0 /usr/share/locale/locale.alias
2010   uname               3   0 /usr/lib/locale/C.UTF-8/LC_IDENTIFICATION
2010   uname               3   0 /usr/lib/x86_64-linux-gnu/gconv/gconv-modules.cache
2010   uname               3   0 /usr/lib/locale/C.UTF-8/LC_MEASUREMENT
2010   uname               3   0 /usr/lib/locale/C.UTF-8/LC_TELEPHONE
2010   uname               3   0 /usr/lib/locale/C.UTF-8/LC_ADDRESS
2010   uname               3   0 /usr/lib/locale/C.UTF-8/LC_NAME
2010   uname               3   0 /usr/lib/locale/C.UTF-8/LC_PAPER
2010   uname               3   0 /usr/lib/locale/C.UTF-8/LC_MESSAGES
2010   uname               3   0 /usr/lib/locale/C.UTF-8/LC_MESSAGES/SYS_LC_MESSAGES
2010   uname               3   0 /usr/lib/locale/C.UTF-8/LC_MONETARY
2010   uname               3   0 /usr/lib/locale/C.UTF-8/LC_COLLATE
2010   uname               3   0 /usr/lib/locale/C.UTF-8/LC_TIME
2010   uname               3   0 /usr/lib/locale/C.UTF-8/LC_NUMERIC
2010   uname               3   0 /usr/lib/locale/C.UTF-8/LC_CTYPE

Можно strace uname -a

man proc
/proc/version
              This string identifies the kernel version that is currently running.  It  includes  the
              contents  of  /proc/sys/kernel/ostype,  /proc/sys/kernel/osrelease  and  /proc/sys/ker‐
              nel/version.  For example:

        Linux version 1.0.9 (quinlan@phaze) #1 Sat May 14 01:51:54 EDT 1994




7. Чем отличается последовательность команд через ; и через && в bash? Например:
root@netology1:~# test -d /tmp/some_dir; echo Hi
Hi
root@netology1:~# test -d /tmp/some_dir && echo Hi
root@netology1:~#
Есть ли смысл использовать в bash &&, если применить set -e?


«;» применяется в случае последовательного выполнения команд
«&&» - последующая комманда выполняется только после успешного выполнения предыдущей
При использовании опции «е» скрипт остановится при возникновении ошибки, будем считать, что в такой постановке вопроса смысла использовать && нет, но мне кажется есть здесь некий подвох ))


8. Из каких опций состоит режим bash set -euxo pipefail и почему его хорошо было бы использовать в сценариях?

-euxo можно представить как набор из 4 опций:
-e стоп при ошибке
-u bash обрабатывает неустановленные переменные как ошибку и немедленно завершает работу
-x печатает команду перед ее выполнением, удобно при отладке
-o проверка команд во всех пайпах



9. Используя -o stat для ps, определите, какой наиболее часто встречающийся статус у процессов в системе. В man psознакомьтесь (/PROCESS STATE CODES) что значат дополнительные к основной заглавной буквы статуса процессов. Его можно не учитывать при расчете (считать S, Ss или Ssl равнозначными).

ps -e -o stat | grep -c -i s
или так ps -e -o stat | grep -c S
48


PROCESS STATE CODES
       Here are the different values that the s, stat and state output specifiers (header "STAT" or
       "S") will display to describe the state of a process:

               D    uninterruptible sleep (usually IO)
               I    Idle kernel thread
               R    running or runnable (on run queue)
               S    interruptible sleep (waiting for an event to complete)
               T    stopped by job control signal
               t    stopped by debugger during the tracing
               W    paging (not valid since the 2.6.xx kernel)
               X    dead (should never be seen)
               Z    defunct ("zombie") process, terminated but not reaped by its parent

       For BSD formats and when the stat keyword is used, additional characters may be displayed:

               <    high-priority (not nice to other users)
               N    low-priority (nice to other users)
               L    has pages locked into memory (for real-time and custom IO)
               s    is a session leader
               l    is multi-threaded (using CLONE_THREAD, like NPTL pthreads do)
               +    is in the foreground process group

