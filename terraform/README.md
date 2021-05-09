#** — Два соседних символа звездочки соответствуют любому файлу или каталогам. Если за ним следует косая черта ( / ), он соответствует только каталогам.

*/.terraform/

#.tfstate файлы

*.tfstate .tfstate.

#фаил crash.log

crash.log

#Файлы типа имена.tfvars *.tfvars

#Файлы override.tf,override.tf.json а также производные *_override.tf и *_override.tf.json

override.tf override.tf.json *_override.tf *_override.tf.json

#Игнорирование файлов .terraformrc terraform.rc

.terraformrc terraform.rc
