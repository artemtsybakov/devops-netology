# Домашнее задание к занятию «Управляющие конструкции в коде Terraform»

### Задание 1
Были созданы 3 ресурса. 
- Сеть develop.
- Подсеть develop.
- Группа безопасности example для сети develop. Так же была создана группа безопасности по умолчанию для сети develop.

![sg_develop.png](./png/sg_develop.png)

![sg_example_dynamic_develop.png](./png/sg_example_dynamic_develop.png)

### Задание 2

Созданы четыре ВМ. Две ВМ методом count с одинаковыми характеристиками и разными названиями.
Две ВМ методом for_each с разными характеристиками.

![yandex_cloud_vm.png](./png/yandex_cloud_vm.png)

### Задание 3

Создал 3 диска.

![yandex_add_3_disk.png](./png/yandex_add_3_disk.png)

Создал ВМ storage

![yandex_add_vm_storage.png](./png/yandex_add_vm_storage.png)

Добавил локальную переменную, в которой собрал идентификаторы диска. На ресурсе преобразовал эту переменную 
в set. Добавил идентификаторы дисков в динамическом блоке.

![yandex_vm_storage_add_disks.png](./png/yandex_vm_storage_add_disks.png)

### Задание 4

![Host.ini](./png/hosts.png)

### Задание 5

Добавил output для ВМ созданных через count и for each.

![outputs.png](./png/outputs.png)

