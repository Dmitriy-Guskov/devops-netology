Домашнее задание к занятию "3.5. Файловые системы"

Узнайте о sparse (разряженных) файлах.

Узнал из вики - https://ru.wikipedia.org/wiki/Разрежённый_файл


Могут ли файлы, являющиеся жесткой ссылкой на один объект, иметь разные права доступа и владельца? Почему?

Нет, ссылка и есть сам файл.


vagrant@vagrant:/tmp$ mkdir testln

vagrant@vagrant:/tmp$ cd testln

vagrant@vagrant:/tmp/testln$ touch testfile.txt

vagrant@vagrant:/tmp/testln$ nano testfile.txt 

vagrant@vagrant:/tmp/testln$ 

vagrant@vagrant:/tmp/testln$ 

vagrant@vagrant:/tmp/testln$ ls -la

total 12

drwxrwxr-x  2 vagrant vagrant 4096 Jun 16 11:38 .

drwxrwxrwt 11 root    root    4096 Jun 16 11:38 ..

-rw-rw-r--  1 vagrant vagrant    7 Jun 16 11:38 testfile.txt

vagrant@vagrant:/tmp/testln$ sudo ln testfile.txt newtestfile.txt 

vagrant@vagrant:/tmp/testln$ ls -la

total 16

drwxrwxr-x  2 vagrant vagrant 4096 Jun 16 11:44 .

drwxrwxrwt 11 root    root    4096 Jun 16 11:38 ..

-rw-rw-r--  2 vagrant vagrant    7 Jun 16 11:38 newtestfile.txt

-rw-rw-r--  2 vagrant vagrant    7 Jun 16 11:38 testfile.txt

vagrant@vagrant:/tmp/testln$ sudo chmod 777 newtestfile.txt 

vagrant@vagrant:/tmp/testln$ ls -la

total 16

drwxrwxr-x  2 vagrant vagrant 4096 Jun 16 11:44 .

drwxrwxrwt 11 root    root    4096 Jun 16 11:38 ..

-rwxrwxrwx  2 vagrant vagrant    7 Jun 16 11:38 newtestfile.txt

-rwxrwxrwx  2 vagrant vagrant    7 Jun 16 11:38 testfile.txt


Используя fdisk, разбейте первый диск на 2 раздела: 2 Гб, оставшееся пространство.

root@vagrant:~# fdisk -l

Disk /dev/sda: 64 GiB, 68719476736 bytes, 134217728 sectors

Disk model: VBOX HARDDISK   

Units: sectors of 1 * 512 = 512 bytes

Sector size (logical/physical): 512 bytes / 512 bytes

I/O size (minimum/optimal): 512 bytes / 512 bytes

Disklabel type: dos

Disk identifier: 0x551c7ad5


Device     Boot   Start       End   Sectors  Size Id Type

/dev/sda1  *       2048   1050623   1048576  512M  b W95 FAT32

/dev/sda2       1052670 134215679 133163010 63.5G  5 Extended

/dev/sda5       1052672 134215679 133163008 63.5G 8e Linux LVM


Disk /dev/sdb: 2.51 GiB, 2684354560 bytes, 5242880 sectors

Disk model: VBOX HARDDISK   

Units: sectors of 1 * 512 = 512 bytes

Sector size (logical/physical): 512 bytes / 512 bytes

I/O size (minimum/optimal): 512 bytes / 512 bytes

Disk /dev/sdc: 2.51 GiB, 2684354560 bytes, 5242880 sectors

Disk model: VBOX HARDDISK   

Units: sectors of 1 * 512 = 512 bytes

Sector size (logical/physical): 512 bytes / 512 bytes

I/O size (minimum/optimal): 512 bytes / 512 bytes





Disk /dev/mapper/vgvagrant-root: 62.55 GiB, 67150807040 bytes, 131153920 sectors

Units: sectors of 1 * 512 = 512 bytes

Sector size (logical/physical): 512 bytes / 512 bytes

I/O size (minimum/optimal): 512 bytes / 512 bytes




Disk /dev/mapper/vgvagrant-swap_1: 980 MiB, 1027604480 bytes, 2007040 sectors

Units: sectors of 1 * 512 = 512 bytes

Sector size (logical/physical): 512 bytes / 512 bytes

I/O size (minimum/optimal): 512 bytes / 512 bytes

root@vagrant:~# 

root@vagrant:~# 

root@vagrant:~# fdisk /dev/sdb

…

root@vagrant:~# 

root@vagrant:~# fdisk -l /dev/sdb

Disk /dev/sdb: 2.51 GiB, 2684354560 bytes, 5242880 sectors

Disk model: VBOX HARDDISK   

Units: sectors of 1 * 512 = 512 bytes

Sector size (logical/physical): 512 bytes / 512 bytes

I/O size (minimum/optimal): 512 bytes / 512 bytes

Disklabel type: dos

Disk identifier: 0x2653001b



Device     Boot   Start     End Sectors  Size Id Type

/dev/sdb1          2048 4196351 4194304    2G 83 Linux

/dev/sdb2       4196352 5242879 1046528  511M 83 Linux

root@vagrant:~# 




Используя sfdisk, перенесите данную таблицу разделов на второй диск.



root@vagrant:~# 

root@vagrant:~# man sfdisk

root@vagrant:~# sfdisk -d /dev/sdb > sdb.txt

root@vagrant:~# cat sdb.txt 

label: dos

label-id: 0x2653001b

device: /dev/sdb

unit: sectors



/dev/sdb1 : start=        2048, size=     4194304, type=83

/dev/sdb2 : start=     4196352, size=     1046528, type=83

root@vagrant:~# sfdisk /dev/sdc < sdb.txt

Checking that no-one is using this disk right now ... OK


Disk /dev/sdc: 2.51 GiB, 2684354560 bytes, 5242880 sectors

Disk model: VBOX HARDDISK   

Units: sectors of 1 * 512 = 512 bytes

Sector size (logical/physical): 512 bytes / 512 bytes

I/O size (minimum/optimal): 512 bytes / 512 bytes

>>> Script header accepted.

>>> Script header accepted.

>>> Script header accepted.

>>> Script header accepted.

>>> Created a new DOS disklabel with disk identifier 0x2653001b.

/dev/sdc1: Created a new partition 1 of type 'Linux' and of size 2 GiB.

/dev/sdc2: Created a new partition 2 of type 'Linux' and of size 511 MiB.

/dev/sdc3: Done.

New situation:

Disklabel type: dos

Disk identifier: 0x2653001b



Device     Boot   Start     End Sectors  Size Id Type

/dev/sdc1          2048 4196351 4194304    2G 83 Linux

/dev/sdc2       4196352 5242879 1046528  511M 83 Linux

The partition table has been altered.

Calling ioctl() to re-read partition table.

Syncing disks.

root@vagrant:~# 

root@vagrant:~# 

root@vagrant:~# fdisk -l /dev/sdc

Disk /dev/sdc: 2.51 GiB, 2684354560 bytes, 5242880 sectors

Disk model: VBOX HARDDISK   

Units: sectors of 1 * 512 = 512 bytes

Sector size (logical/physical): 512 bytes / 512 bytes

I/O size (minimum/optimal): 512 bytes / 512 bytes

Disklabel type: dos

Disk identifier: 0x2653001b



Device     Boot   Start     End Sectors  Size Id Type

/dev/sdc1          2048 4196351 4194304    2G 83 Linux

/dev/sdc2       4196352 5242879 1046528  511M 83 Linux

root@vagrant:~# 



Соберите mdadm RAID1 на паре разделов 2 Гб. Соберите mdadm RAID0 на второй паре маленьких разделов.

root@vagrant:~# man mdadm

root@vagrant:~# 

root@vagrant:~# mdadm --create --verbose /dev/md0 -l 1 -n 2 /dev/sdb1 /dev/sdc1

mdadm: Note: this array has metadata at the start and

    may not be suitable as a boot device.  If you plan to


    store '/boot' on this device please ensure that

    your boot-loader understands md/v1.x metadata, or use
    --metadata=0.90

mdadm: size set to 2094080K

Continue creating array? y

mdadm: Defaulting to version 1.2 metadata


mdadm: array /dev/md0 started.
root@vagrant:~# 

root@vagrant:~# 

root@vagrant:~# mdadm --create --verbose /dev/md1 -l 0 -n 2 /dev/sdb2 /dev/sdc2

mdadm: chunk size defaults to 512K

mdadm: Defaulting to version 1.2 metadata

mdadm: array /dev/md1 started.

root@vagrant:~# 

root@vagrant:~# 

root@vagrant:~# lsblk

NAME                 MAJ:MIN RM  SIZE RO TYPE  MOUNTPOINT

sda                    8:0    0   64G  0 disk  

├─sda1                 8:1    0  512M  0 part  /boot/efi

├─sda2                 8:2    0    1K  0 part  

└─sda5                 8:5    0 63.5G  0 part  

  ├─vgvagrant-root   253:0    0 62.6G  0 lvm   /

  └─vgvagrant-swap_1 253:1    0  980M  0 lvm   [SWAP]

sdb                    8:16   0  2.5G  0 disk  

├─sdb1                 8:17   0    2G  0 part  

│ └─md0                9:0    0    2G  0 raid1 

└─sdb2                 8:18   0  511M  0 part  

  └─md1                9:1    0 1018M  0 raid0 

sdc                    8:32   0  2.5G  0 disk  

├─sdc1                 8:33   0    2G  0 part  

│ └─md0                9:0    0    2G  0 raid1 

└─sdc2                 8:34   0  511M  0 part  

  └─md1                9:1    0 1018M  0 raid0 

root@vagrant:~# 




Создайте 2 независимых PV на получившихся md-устройствах.


root@vagrant:~# pvcreate /dev/md0 

  Physical volume "/dev/md0" successfully created.

root@vagrant:~# pvcreate /dev/md1

  Physical volume "/dev/md1" successfully created.

root@vagrant:~# pvs

  PV         VG        Fmt  Attr PSize    PFree   

  /dev/md0             lvm2 ---    <2.00g   <2.00g

  /dev/md1             lvm2 ---  1018.00m 1018.00m

  /dev/sda5  vgvagrant lvm2 a--   <63.50g       0 

root@vagrant:~# 




Создайте общую volume-group на этих двух PV.



root@vagrant:~# man vgcreate

root@vagrant:~# vgcreate vgrp /dev/md0 /dev/md1 

  Volume group "vgrp" successfully created

root@vagrant:~# pvs

  PV         VG        Fmt  Attr PSize    PFree   

  /dev/md0   vgrp      lvm2 a--    <2.00g   <2.00g

  /dev/md1   vgrp      lvm2 a--  1016.00m 1016.00m

  /dev/sda5  vgvagrant lvm2 a--   <63.50g       0 

root@vagrant:~# 



Создайте LV размером 100 Мб, указав его расположение на PV с RAID0.


root@vagrant:~# lvcreate -L 100M -n data100 vgrp /dev/md1

  Logical volume "data100" created.

root@vagrant:~# lvdisplay vgrp

  --- Logical volume ---

  LV Path                /dev/vgrp/data100

  LV Name                data100

  VG Name                vgrp

  LV UUID                Skayvd-u600-nMUd-UseE-I5yQ-oGT8-emhCr3

  LV Write Access        read/write

  LV Creation host, time vagrant, 2021-06-16 14:04:43 +0000

  LV Status              available

  # open                 0

  LV Size                100.00 MiB

  Current LE             25

  Segments               1

  Allocation             inherit

  Read ahead sectors     auto

  - currently set to     4096

  Block device           253:2

root@vagrant:~# 


Создайте mkfs.ext4 ФС на получившемся LV.


root@vagrant:~# mkfs.ext4 /dev/vgrp/data100

mke2fs 1.45.5 (07-Jan-2020)

Creating filesystem with 25600 4k blocks and 25600 inodes

Allocating group tables: done                            

Writing inode tables: done                            

Creating journal (1024 blocks): done

Writing superblocks and filesystem accounting information: done


root@vagrant:~# 




Смонтируйте этот раздел в любую директорию, например, /tmp/new.


root@vagrant:~# mkdir /tmp/new

root@vagrant:~# mount /dev/vgrp/data100 /tmp/new

root@vagrant:~# 



Поместите туда тестовый файл, например wget https://mirror.yandex.ru/ubuntu/ls-lR.gz -O /tmp/new/test.gz.


root@vagrant:~# wget https://mirror.yandex.ru/ubuntu/ls-lR.gz -O /tmp/new/test.gz

--2021-06-16 14:14:04--  https://mirror.yandex.ru/ubuntu/ls-lR.gz

Resolving mirror.yandex.ru (mirror.yandex.ru)... 213.180.204.183, 2a02:6b8::183

Connecting to mirror.yandex.ru (mirror.yandex.ru)|213.180.204.183|:443... connected.

HTTP request sent, awaiting response... 200 OK

Length: 20893574 (20M) [application/octet-stream]

Saving to: ‘/tmp/new/test.gz’


/tmp/new/test.gz              100%[================================================>]  19.92M  7.11MB/s    in 2.8s    

2021-06-16 14:14:06 (7.11 MB/s) - ‘/tmp/new/test.gz’ saved [20893574/20893574]

root@vagrant:~# 



root@vagrant:~# ls -la /tmp/new/

total 20428

drwxr-xr-x  3 root root     4096 Jun 16 14:14 .

drwxrwxrwt 11 root root     4096 Jun 16 14:12 ..

drwx------  2 root root    16384 Jun 16 14:11 lost+found

-rw-r--r--  1 root root 20893574 Jun 16 12:26 test.gz

root@vagrant:~# 






Прикрепите вывод lsblk.


root@vagrant:~# 

root@vagrant:~# lsblk

NAME                 MAJ:MIN RM  SIZE RO TYPE  MOUNTPOINT

sda                    8:0    0   64G  0 disk  

├─sda1                 8:1    0  512M  0 part  /boot/efi

├─sda2                 8:2    0    1K  0 part  

└─sda5                 8:5    0 63.5G  0 part  

  ├─vgvagrant-root   253:0    0 62.6G  0 lvm   /

  └─vgvagrant-swap_1 253:1    0  980M  0 lvm   [SWAP]

sdb                    8:16   0  2.5G  0 disk  

├─sdb1                 8:17   0    2G  0 part  

│ └─md0                9:0    0    2G  0 raid1 

└─sdb2                 8:18   0  511M  0 part  

  └─md1                9:1    0 1018M  0 raid0 

    └─vgrp-data100   253:2    0  100M  0 lvm   /tmp/new

sdc                    8:32   0  2.5G  0 disk  

├─sdc1                 8:33   0    2G  0 part  

│ └─md0                9:0    0    2G  0 raid1 

└─sdc2                 8:34   0  511M  0 part  

  └─md1                9:1    0 1018M  0 raid0 

    └─vgrp-data100   253:2    0  100M  0 lvm   /tmp/new

root@vagrant:~# 

root@vagrant:~# 


Протестируйте целостность файла:


root@vagrant:~# gzip -t /tmp/new/test.gz

root@vagrant:~# echo $?

0

root@vagrant:~# man gzip




Используя pvmove, переместите содержимое PV с RAID0 на RAID1.

root@vagrant:~# man pvmove

root@vagrant:~# pvmove -b /dev/md1 /dev/md0

root@vagrant:~# 


root@vagrant:~# pvdisplay /dev/md1 /dev/md0

  --- Physical volume ---

  PV Name               /dev/md0

  VG Name               vgrp

  PV Size               <2.00 GiB / not usable 0   

  Allocatable           yes 

  PE Size               4.00 MiB

  Total PE              511

  Free PE               486

  Allocated PE          25

  PV UUID               KthiI5-a27q-3L7J-2q5W-b3gC-dFF7-LcOHZP


  --- Physical volume ---

  PV Name               /dev/md1

  VG Name               vgrp

  PV Size               1018.00 MiB / not usable 2.00 MiB

  Allocatable           yes 

  PE Size               4.00 MiB

  Total PE              254

  Free PE               254

  Allocated PE          0

  PV UUID               hT4Bzc-RxLd-TVZk-fZ5J-11Ip-oxR7-CZg3qt

  
root@vagrant:~# 




Сделайте --fail на устройство в вашем RAID1 md.


root@vagrant:~# mdadm --detail /dev/md0

/dev/md0:

           Version : 1.2

     Creation Time : Wed Jun 16 13:52:05 2021

        Raid Level : raid1

        Array Size : 2094080 (2045.00 MiB 2144.34 MB)

     Used Dev Size : 2094080 (2045.00 MiB 2144.34 MB)

      Raid Devices : 2

     Total Devices : 2

       Persistence : Superblock is persistent


       Update Time : Wed Jun 16 14:20:49 2021

             State : clean 

    Active Devices : 2

   Working Devices : 2

    Failed Devices : 0

     Spare Devices : 0

Consistency Policy : resync

              Name : vagrant:0  (local to host vagrant)

              UUID : a4753fac:7c7bf2e1:0da89b05:1a0d488e

            Events : 17


    Number   Major   Minor   RaidDevice State

       0       8       17        0      active sync   /dev/sdb1

       1       8       33        1      active sync   /dev/sdc1

root@vagrant:~# 

root@vagrant:~# 

root@vagrant:~# 

root@vagrant:~# mdadm /dev/md0 -f /dev/sdc1

mdadm: set /dev/sdc1 faulty in /dev/md0

root@vagrant:~# mdadm --detail /dev/md0

/dev/md0:

           Version : 1.2

     Creation Time : Wed Jun 16 13:52:05 2021

        Raid Level : raid1

        Array Size : 2094080 (2045.00 MiB 2144.34 MB)

     Used Dev Size : 2094080 (2045.00 MiB 2144.34 MB)

      Raid Devices : 2

     Total Devices : 2

       Persistence : Superblock is persistent

       Update Time : Wed Jun 16 14:29:34 2021

             State : clean, degraded 

    Active Devices : 1

   Working Devices : 1

    Failed Devices : 1

     Spare Devices : 0

Consistency Policy : resync

              Name : vagrant:0  (local to host vagrant)

              UUID : a4753fac:7c7bf2e1:0da89b05:1a0d488e

            Events : 19


    Number   Major   Minor   RaidDevice State

       0       8       17        0      active sync   /dev/sdb1

       -       0        0        1      removed

       1       8       33        -      faulty   /dev/sdc1

root@vagrant:~# 



Подтвердите выводом dmesg, что RAID1 работает в деградированном состоянии.


root@vagrant:~# dmesg |grep md0

[ 1751.697058] md/raid1:md0: not clean -- starting background reconstruction

[ 1751.697060] md/raid1:md0: active with 2 out of 2 mirrors

[ 1751.697079] md0: detected capacity change from 0 to 2144337920

[ 1751.702679] md: resync of RAID array md0

[ 1761.835428] md: md0: resync done.

[ 4000.175258] md/raid1:md0: Disk failure on sdc1, disabling device.

               md/raid1:md0: Operation continuing on 1 devices.




Протестируйте целостность файла, несмотря на "сбойный" диск он должен продолжать быть доступен:


root@vagrant:~# gzip -t /tmp/new/test.gz

root@vagrant:~# echo $?

0

root@vagrant:~# 



