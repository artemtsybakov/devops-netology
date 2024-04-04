# Домашнее задание к занятию 3. «MySQL»
## Введение
Перед выполнением задания вы можете ознакомиться с [дополнительными материалами](https://github.com/netology-code/virt-homeworks/blob/virt-11/additional/README.md).
## Задача 1
#### Используя Docker, поднимите инстанс MySQL (версию 8). Данные БД сохраните в volume.
*Использую образ из репозитория [dockerhub](https://hub.docker.com/_/mysql)*  
```shell
docker pull mysql:8.0
```
*Создал контейнер командой*  
```shell
docker run --name=mysql1 \
--restart on-failure \
--env MYSQL_RANDOM_ROOT_PASSWORD="true" \
--mount type=bind,src=/home/artem/docker3/volumes/mysql/volume/,dst=/var/lib/mysql \
--mount type=bind,src=/home/artem/docker3/volumes/mysql/backup/,dst=/data/backups \
-d mysql:8.0 
```
*Узнаю одноразовый пароль от учетной записи root.*  
```shell
docker logs mysql1 2>&1 | grep GENERATED
```
*Подключаюсь к контейнеру, что бы изменить одноразовый пароль root на постоянный.*  
```shell
docker exec -it mysql1 mysql -uroot -p
```
*Меняю пароль.*  
```text
ALTER USER 'root'@'localhost' IDENTIFIED BY 'pass';
```
#### Изучите [бэкап БД](https://github.com/netology-code/virt-homeworks/tree/virt-11/06-db-03-mysql/test_data) и восстановитесь из него.  
*Чтобы восстановить БД из архива, нужно подключиться к MySQL в контейнере*
```shell
docker exec -it mysql1 mysql -uroot -p
```
*Создать БД на сервере* 
```text
CREATE DATABASE test_db;
```
*Подключиться к созданной базе*
```text
USE test_db
```
*Восстановить из файла*
```text
SOURCE /data/backups/test_dump.sql
```
#### Перейдите в управляющую консоль `mysql` внутри контейнера.
#### Используя команду `\h`, получите список управляющих команд.
#### Найдите команду для выдачи статуса БД и **приведите в ответе** из её вывода версию сервера БД.  
*Команда для выдачи статуса ``\s``*  
``Server version:         8.0.36 MySQL Community Server - GPL``
#### Подключитесь к восстановленной БД и получите список таблиц из этой БД.
```text
mysql> SHOW TABLES;
+-------------------+
| Tables_in_test_db |
+-------------------+
| orders            |
+-------------------+
1 row in set (0.00 sec)
```
#### **Приведите в ответе** количество записей с `price` > 300.  
```text
SELECT COUNT(*) FROM orders WHERE price > 300;
```
*В результате получил одну запись.* 
```text
+----------+
| COUNT(*) |
+----------+
|        1 |
+----------+
1 row in set (0.00 sec)
```
В следующих заданиях мы будем продолжать работу с этим контейнером.  
## Задача 2  
Создайте пользователя tet в БД c паролем test-pass, используя:
- плагин авторизации mysql_native_password
- срок истечения пароля — 180 дней 
- количество попыток авторизации — 3 
- максимальное количество запросов в час — 100
- аттрибуты пользователя:
  - Фамилия "Pretty"
  - Имя "James".
```text
CREATE USER IF NOT EXISTS 
  'test'@'localhost' IDENTIFIED WITH mysql_native_password BY 'test-pass'
  WITH MAX_QUERIES_PER_HOUR 100 PASSWORD EXPIRE INTERVAL 180 DAY FAILED_LOGIN_ATTEMPTS 3
  ATTRIBUTE '{"fname": "Pretty", "lname": "James"}';
```
Предоставьте привилегии пользователю `test` на операции SELECT базы `test_db`.  
```text
GRANT SELECT ON test_db.* TO 'test'@'localhost';
```
```text
SHOW GRANTS FOR 'test'@'localhost';
```
```text
+---------------------------------------------------+
| Grants for test@localhost                         |
+---------------------------------------------------+
| GRANT USAGE ON *.* TO `test`@`localhost`          |
| GRANT SELECT ON `test_db`.* TO `test`@`localhost` |
+---------------------------------------------------+
2 rows in set (0.00 sec)
```
Используя таблицу INFORMATION_SCHEMA.USER_ATTRIBUTES, получите данные по пользователю `test` и **приведите 
в ответе к задаче**.
```sql
SELECT USER AS 'User',
       HOST AS 'Host',
       CONCAT(ATTRIBUTE->>"$.fname"," ",ATTRIBUTE->>"$.lname") AS 'Full name'
  FROM INFORMATION_SCHEMA.USER_ATTRIBUTES
 WHERE USER='test' AND HOST='localhost';
```
```text
+------+-----------+--------------+
| User | Host      | Full name    |
+------+-----------+--------------+
| test | localhost | Pretty James |
+------+-----------+--------------+
1 row in set (0.00 sec)
```
## Задача 3
Установите профилирование `SET profiling = 1`.  
Изучите вывод профилирования команд `SHOW PROFILES;`.

*В выводе этой команды показаны последние инструкции которые были направленны на сервер. Количество записей можно
регулировать. Информацию можно фильтровать по типу.*

Исследуйте, какой `engine` используется в таблице БД `test_db` и **приведите в ответе**.  

*Что бы посмотреть какой механизм работы с таблицами используется по умолчанию, нужно ввести команду
`SHOW ENGINES\G`. По умолчанию используется `InnoDB`. Так же механизм работы можно указать при создании таблицы. Для 
этого используется опция ENGINE.*   

Измените `engine` и **приведите время выполнения и запрос на изменения из профайлера в ответе**:
- на `MyISAM`,
- на `InnoDB`.

```text
ALTER TABLE orders ENGINE = MyISAM;
``` 
```text
Query OK, 5 rows affected (0.01 sec)
Records: 5  Duplicates: 0  Warnings: 0
```
```text
ALTER TABLE orders ENGINE = InnoDB;
``` 
```text
Query OK, 5 rows affected (0.01 sec)
Records: 5  Duplicates: 0  Warnings: 0
```
## Задача 4
*По указанном каталоге `/etc/mysql/my.cnf` файла не было. Получил ошибку.*    
```text
artem@yas-010:/mnt/WorkSSD/git/devops-netology/db/06-db-03-mysql$ docker cp mysql1:/etc/mysql/my.cnf .
Error response from daemon: Could not find the file /etc/mysql/my.cnf in container mysql1
```
*Что бы проверить читает ли программа файл опций, нужно запустить `mysql --help`. Там же видно, где хранится файл.*
*Скопировал файл из `/etc/my.cnf`*  
```text
artem@yas-010:/mnt/WorkSSD/git/devops-netology/db/06-db-03-mysql$ docker cp mysql1:/etc/my.cnf .
Successfully copied 3.07kB to /mnt/WorkSSD/git/devops-netology/db/06-db-03-mysql/.
```
*[Ссылка на файл](./file/my.cnf)*  

Изучите файл `my.cnf` в директории /etc/mysql.  
Измените его согласно ТЗ (движок InnoDB):
- скорость IO важнее сохранности данных;
- нужна компрессия таблиц для экономии места на диске;
- размер буфера с незакомиченными транзакциями 1 Мб;
- буфер кеширования 30% от ОЗУ;
- размер файла логов операций 100 Мб.
Приведите в ответе изменённый файл `my.cnf`.
---
### Как оформить ДЗ
Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.
---