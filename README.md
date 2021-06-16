Домашнее задание к занятию "3.4. Операционные системы, лекция 2"
1.	На лекции мы познакомились с node_exporter. В демонстрации его исполняемый файл запускался в background. Этого достаточно для демо, но не для настоящей production-системы, где процессы должны находиться под внешним управлением. Используя знания из лекции по systemd, создайте самостоятельно простой unit-файл для node_exporter:
o	поместите его в автозагрузку,
o	предусмотрите возможность добавления опций к запускаемому процессу через внешний файл (посмотрите, например, на systemctl cat cron),
o	удостоверьтесь, что с помощью systemctl процесс корректно стартует, завершается, а после перезагрузки автоматически поднимается.


sudo wget https://github.com/prometheus/node_exporter/releases/download/v1.1.2/node_exporter-1.1.2.linux-amd64.tar.gz

tar -xvf node_exporter*

sudo cp node_exporter*/node_exporter /usr/local/bin

sudo useradd -rs /bin/false node_exporter

sudo nano /etc/systemd/system/node_exporter.service


 [Unit]

Description=Node Exporter

[Service]

User=node_exporter

EnvironmentFile=/etc/node_exporter

ExecStart=/usr/local/bin/node_exporter $OPTIONS

[Install]

WantedBy=multi-user.target


sudo nano /etc/node_exporter



OPTIONS="–collector.textfile.directory /var/lib/node_exporter/textfile_collector"



sudo systemctl daemon-reload

sudo systemctl start node_exporter

sudo systemctl status node_exporter

vagrant@vagrant:~$ sudo systemctl status node_exporter
● node_exporter.service - Node Exporter
     Loaded: loaded (/etc/systemd/system/node_exporter.service; disabled; vendor preset: enabled)
     Active: active (running) since Tue 2021-06-15 18:41:40 UTC; 6s ago
   Main PID: 1355 (node_exporter)
      Tasks: 3 (limit: 1074)
     Memory: 2.0M
     CGroup: /system.slice/node_exporter.service
             └─1355 /usr/local/bin/node_exporter --collector.textfile.directory /var/lib/node_exporter/textfile_c>

Jun 15 18:41:40 vagrant node_exporter[1355]: level=info ts=2021-06-15T18:41:40.999Z caller=node_exporter.go:113 c>

Jun 15 18:41:41 vagrant node_exporter[1355]: level=info ts=2021-06-15T18:41:41.000Z caller=node_exporter.go:113 c>

Jun 15 18:41:41 vagrant node_exporter[1355]: level=info ts=2021-06-15T18:41:41.000Z caller=node_exporter.go:113 c>

Jun 15 18:41:41 vagrant node_exporter[1355]: level=info ts=2021-06-15T18:41:41.000Z caller=node_exporter.go:113 c>

Jun 15 18:41:41 vagrant node_exporter[1355]: level=info ts=2021-06-15T18:41:41.000Z caller=node_exporter.go:113 c>

Jun 15 18:41:41 vagrant node_exporter[1355]: level=info ts=2021-06-15T18:41:41.000Z caller=node_exporter.go:113 c>

Jun 15 18:41:41 vagrant node_exporter[1355]: level=info ts=2021-06-15T18:41:41.000Z caller=node_exporter.go:113 c>

Jun 15 18:41:41 vagrant node_exporter[1355]: level=info ts=2021-06-15T18:41:41.000Z caller=node_exporter.go:113 c>

Jun 15 18:41:41 vagrant node_exporter[1355]: level=info ts=2021-06-15T18:41:41.001Z caller=node_exporter.go:195 m>

Jun 15 18:41:41 vagrant node_exporter[1355]: level=info ts=2021-06-15T18:41:41.001Z caller=tls_config.go:191 msg=>



2.	Ознакомьтесь с опциями node_exporter и выводом /metrics по-умолчанию. Приведите несколько опций, которые вы бы выбрали для базового мониторинга хоста по CPU, памяти, диску и сети.

vagrant@vagrant:~$ curl http://localhost:9100/metrics |grep cpu
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0# HELP go_memstats_gc_cpu_fraction The fraction of this program's available CPU time used by the GC since the program started.
# TYPE go_memstats_gc_cpu_fraction gauge
go_memstats_gc_cpu_fraction 0
# HELP node_cpu_guest_seconds_total Seconds the CPUs spent in guests (VMs) for each mode.
# TYPE node_cpu_guest_seconds_total counter
node_cpu_guest_seconds_total{cpu="0",mode="nice"} 0
node_cpu_guest_seconds_total{cpu="0",mode="user"} 0
# HELP node_cpu_seconds_total Seconds the CPUs spent in each mode.
# TYPE node_cpu_seconds_total counter
node_cpu_seconds_total{cpu="0",mode="idle"} 2254.79
node_cpu_seconds_total{cpu="0",mode="iowait"} 1.43
node_cpu_seconds_total{cpu="0",mode="irq"} 0
node_cpu_seconds_total{cpu="0",mode="nice"} 0.04
node_cpu_seconds_total{cpu="0",mode="softirq"} 0.12
node_cpu_seconds_total{cpu="0",mode="steal"} 0
node_cpu_seconds_total{cpu="0",mode="system"} 3.8
node_cpu_seconds_total{cpu="0",mode="user"} 2.71
# HELP node_memory_Percpu_bytes Memory information field Percpu_bytes.
# TYPE node_memory_Percpu_bytes gauge
node_memory_Percpu_bytes 638976
# HELP node_pressure_cpu_waiting_seconds_total Total time in seconds that processes have waited for CPU time
# TYPE node_pressure_cpu_waiting_seconds_total counter
node_pressure_cpu_waiting_seconds_total 4.904951
node_schedstat_running_seconds_total{cpu="0"} 11.346300779
node_schedstat_timeslices_total{cpu="0"} 496971
node_schedstat_waiting_seconds_total{cpu="0"} 23.456731203
node_scrape_collector_duration_seconds{collector="cpu"} 0.000144411
node_scrape_collector_duration_seconds{collector="cpufreq"} 4.1248e-05
node_scrape_collector_success{collector="cpu"} 1
node_scrape_collector_success{collector="cpufreq"} 1
node_softnet_dropped_total{cpu="0"} 0
node_softnet_processed_total{cpu="0"} 7755
node_softnet_times_squeezed_total{cpu="0"} 0
# HELP process_cpu_seconds_total Total user and system CPU time spent in seconds.
# TYPE process_cpu_seconds_total counter
process_cpu_seconds_total 0
100 58024    0 58024    0     0  3148k      0 --:--:-- --:--:-- --:--:-- 3148k


upd1
vagrant@vagrant:~$ curl http://localhost:9100/metrics |grep eth
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0node_arp_entries{device="eth0"} 1
# HELP node_filesystem_device_error Whether an error occurred while getting statistics for the given device.
node_network_address_assign_type{device="eth0"} 0
node_network_carrier{device="eth0"} 1
node_network_carrier_changes_total{device="eth0"} 2
node_network_carrier_down_changes_total{device="eth0"} 1
node_network_carrier_up_changes_total{device="eth0"} 1
node_network_device_id{device="eth0"} 0
node_network_dormant{device="eth0"} 0
node_network_flags{device="eth0"} 4099
node_network_iface_id{device="eth0"} 2
node_network_iface_link{device="eth0"} 2
node_network_iface_link_mode{device="eth0"} 0
node_network_info{address="08:00:27:14:86:db",broadcast="ff:ff:ff:ff:ff:ff",device="eth0",duplex="full",ifalias="",operstate="up"} 1
node_network_mtu_bytes{device="eth0"} 1500
node_network_net_dev_group{device="eth0"} 0
node_network_protocol_type{device="eth0"} 1
node_network_receive_bytes_total{device="eth0"} 93315
node_network_receive_compressed_total{device="eth0"} 0
node_network_receive_drop_total{device="eth0"} 0
node_network_receive_errs_total{device="eth0"} 0
node_network_receive_fifo_total{device="eth0"} 0
node_network_receive_frame_total{device="eth0"} 0
node_network_receive_multicast_total{device="eth0"} 0
node_network_receive_packets_total{device="eth0"} 973
node_network_speed_bytes{device="eth0"} 1.25e+08
node_network_transmit_bytes_total{device="eth0"} 107647
node_network_transmit_carrier_total{device="eth0"} 0
node_network_transmit_colls_total{device="eth0"} 0
node_network_transmit_compressed_total{device="eth0"} 0
node_network_transmit_drop_total{device="eth0"} 0
node_network_transmit_errs_total{device="eth0"} 0
node_network_transmit_fifo_total{device="eth0"} 0
node_network_transmit_packets_total{device="eth0"} 784
node_network_transmit_queue_length{device="eth0"} 1000
node_network_up{device="eth0"} 1
# HELP node_scrape_collector_success node_exporter: Whether a collector succeeded.
100 58085    0 58085    0     0  2985k      0 --:--:-- --:--:-- --:--:-- 2985k






3.	Установите в свою виртуальную машину Netdata. Воспользуйтесь готовыми пакетами для установки (sudo apt install -y netdata). После успешной установки:
o	в конфигурационном файле /etc/netdata/netdata.conf в секции [web] замените значение с localhost на bind to = 0.0.0.0,
o	добавьте в Vagrantfile проброс порта Netdata на свой локальный компьютер и сделайте vagrant reload:
config.vm.network "forwarded_port", guest: 19999, host: 19999
После успешной перезагрузки в браузере на своем ПК (не в виртуальной машине) вы должны суметь зайти на localhost:19999. Ознакомьтесь с метриками, которые по умолчанию собираются Netdata и с комментариями, которые даны к этим метрикам.

vagrant@vagrant:~$ sudo apt install -y netdata
Reading package lists... Done
Building dependency tree       
Reading state information... Done
The following additional packages will be installed:
  fonts-font-awesome fonts-glyphicons-halflings freeipmi-common libc-ares2 libfreeipmi17 libipmimonitoring6
  libjs-bootstrap libjudydebian1 libnetfilter-acct1 libnode64 netdata-core netdata-plugins-bash
  netdata-plugins-nodejs netdata-plugins-python netdata-web nodejs nodejs-doc
Suggested packages:
  freeipmi-tools apcupsd hddtemp lm-sensors nc fping python3-psycopg2 python3-pymysql npm
The following NEW packages will be installed:
  fonts-font-awesome fonts-glyphicons-halflings freeipmi-common libc-ares2 libfreeipmi17 libipmimonitoring6
  libjs-bootstrap libjudydebian1 libnetfilter-acct1 libnode64 netdata netdata-core netdata-plugins-bash
  netdata-plugins-nodejs netdata-plugins-python netdata-web nodejs nodejs-doc
0 upgraded, 18 newly installed, 0 to remove and 0 not upgraded.



vagrant@vagrant:~$ sudo systemctl status netdata
● netdata.service - netdata - Real-time performance monitoring
     Loaded: loaded (/lib/systemd/system/netdata.service; enabled; vendor preset: enabled)
     Active: active (running) since Tue 2021-06-15 19:00:45 UTC; 3min 26s ago
       Docs: man:netdata
             file:///usr/share/doc/netdata/html/index.html
             https://github.com/netdata/netdata
   Main PID: 763 (netdata)
      Tasks: 21 (limit: 1074)
     Memory: 69.3M
     CGroup: /system.slice/netdata.service
             ├─763 /usr/sbin/netdata -D
             ├─837 /usr/lib/netdata/plugins.d/nfacct.plugin 1
             ├─840 bash /usr/lib/netdata/plugins.d/tc-qos-helper.sh 1
             └─843 /usr/lib/netdata/plugins.d/apps.plugin 1

Jun 15 19:00:45 vagrant systemd[1]: Started netdata - Real-time performance monitoring.
Jun 15 19:00:45 vagrant netdata[763]: SIGNAL: Not enabling reaper
Jun 15 19:00:45 vagrant netdata[763]: 2021-06-15 19:00:45: netdata INFO  : MAIN : SIGNAL: Not enabling reaper



4.	Можно ли по выводу dmesg понять, осознает ли ОС, что загружена не на настоящем оборудовании, а на системе виртуализации?

vagrant@vagrant:~$ sudo dmesg |grep vir
[    0.003033] CPU MTRRs all blank - virtualized system.
[    0.132066] Booting paravirtualized kernel on KVM
[    4.359835] systemd[1]: Detected virtualization oracle.


5.	Как настроен sysctl fs.nr_open на системе по-умолчанию? Узнайте, что означает этот параметр. Какой другой существующий лимит не позволит достичь такого числа (ulimit --help)?

https://access.redhat.com/solutions/1479623
•	The default value fs.nr_open is 1024*1024 = 1048576.
•	The maximum value of fs.nr_open is limited to sysctl_nr_open_max in kernel, which is 2147483584 on x86_64.

vagrant@vagrant:~$ sysctl fs.nr_open
fs.nr_open = 1048576
vagrant@vagrant:~$ sudo sysctl -w fs.nr_open=2147483584
fs.nr_open = 2147483584
vagrant@vagrant:~$ ulimit -n 2147483584
-bash: ulimit: open files: cannot modify limit: Operation not permitted
vagrant@vagrant:~$ sudo -i
root@vagrant:~# ulimit -n 2147483584
root@vagrant:~# ulimit -n
2147483584
root@vagrant:~# sysctl -w fs.nr_open=2147483585
sysctl: setting key "fs.nr_open": Invalid argument




6.	Запустите любой долгоживущий процесс (не ls, который отработает мгновенно, а, например, sleep 1h) в отдельном неймспейсе процессов; покажите, что ваш процесс работает под PID 1 через nsenter. Для простоты работайте в данном задании под root (sudo -i). Под обычным пользователем требуются дополнительные опции (--map-root-user) и т.д.

root@vagrant:~# screen
root@vagrant:~# unshare -f --pid --mount-proc sleep 1h

vagrant@vagrant:~$ ps -a |grep sleep
   1582 pts/0    00:00:00 sleep
vagrant@vagrant:~$ sudo -i
root@vagrant:~# nsenter --target 1582 --pid --mount
root@vagrant:/# ps -aux |grep sleep
root           1  0.0  0.0   9828   528 pts/0    S+   19:53   0:00 sleep 1h
root          12  0.0  0.0  10760   724 pts/1    S+   19:56   0:00 grep --color=auto sleep



7.	Найдите информацию о том, что такое :(){ :|:& };:. Запустите эту команду в своей виртуальной машине Vagrant с Ubuntu 20.04 (это важно, поведение в других ОС не проверялось). Некоторое время все будет "плохо", после чего (минуты) – ОС должна стабилизироваться. Вызов dmesg расскажет, какой механизм помог автоматической стабилизации. Как настроен этот механизм по-умолчанию, и как изменить число процессов, которое можно создать в сессии?

:(){:|:&};: -Fork Bomb
Создаём функцию, которая циклически удваивается и не может закончится.

Результат самовостановления системы по ограничению количества сесий на пользователя.
root@vagrant:/# journalctl -f
-- Logs begin at Thu 2021-05-20 19:09:03 UTC. --
Jun 15 20:02:45 vagrant kernel: cgroup: fork rejected by pids controller in /user.slice/user-1000.slice/session-6.scope


