
6.
config.vm.provider "virtualbox" do |vb|
# Customize the amount of memory on the VM:
vb.memory = "1024"
vb.cpus = "22"
end




8.
HISTORY
line 3444
HISTSIZE
Line 3455


Ignoreboth - не записывать команду, которая начинается с пробела или которая дублирует предыдущую

9.
Line 178
       !  case  coproc  do done elif else esac fi for function if in select then until while { }
       time [[ ]]
Обычно {} применяют при создании функций bash



10.
touch {1..100000}.txt
300000 – получается слишком длинная команда, xargs?
getconf ARG_MAX – 2097152


11.
[[ -d /tmp ]]
Конструкция проверяет наличие папки тмп и на выходе получаем логическую переменную



12.
Добавил ссылку - sudo ln -s /usr/bin/bash /usr/local/bin/bash

После этого вывод type -a bash стал следующий:
bash is /usr/local/bin/bash
bash is /usr/bin/bash
bash is /bin/bash

добавить /tmp/new_path_directory/bash так и не получилось, идеи кончились



13.
Отличие в том, что batch запускает задачу только если загрузка системы меньше установленного минимума

