# Домашнее задание к занятию 4.«PostgreSQL»
## Задача 1
Используя Docker, поднимите инстанс PostgreSQL (версию 13). Данные БД сохраните в volume.
```shell
docker run --name 06-db-04-postgresql \
-e POSTGRES_USER=postgres \
-e POSTGRES_PASSWORD=postgres \
-v /home/artem/docker4/volumes/postgres/volume:/var/lib/postgresql/data \
-v /home/artem/docker4/volumes/postgres/backups:/backups \
-d postgres:13
```
Подключитесь к БД PostgreSQL, используя `psql`. 
```shell
docker exec -it 06-db-04-postgresql psql -U postgres
```
Воспользуйтесь командой `\?` для вывода подсказки по имеющимся в `psql` управляющим командам.  
**Найдите и приведите** управляющие команды для:
- вывода списка БД, `\l`
- подключения к БД, `\c`
- вывода списка таблиц, `\dt`
- вывода описания содержимого таблиц, `\d+ имя_таблицы`
- выхода из psql. `\q`
## Задача 2
Используя `psql`, создайте БД `test_database`.  
```shell
docker exec -i 06-db-04-postgresql createdb -U postgres test_database
```
Изучите [бэкап БД](https://github.com/netology-code/virt-homeworks/tree/virt-11/06-db-04-postgresql/test_data).  
Восстановите бэкап БД в `test_database`. 
```shell
docker exec -i 06-db-04-postgresql psql -U postgres test_database -f /backups/test_dump.sql
```
Перейдите в управляющую консоль `psql` внутри контейнера.
Подключитесь к восстановленной БД и проведите операцию ANALYZE для сбора статистики по таблице.  
Используя таблицу [pg_stats](https://postgrespro.ru/docs/postgresql/12/view-pg-stats), найдите столбец таблицы `orders` 
с наибольшим средним значением размера элементов в байтах.  
**Приведите в ответе** команду, которую вы использовали для вычисления, и полученный результат.
```shell
docker exec -it 06-db-04-postgresql psql -U postgres test_database
```
```sql
ANALYZE orders;
```
```sql
SELECT tablename,
       attname, 
       avg_width 
  FROM pg_stats 
 WHERE tablename = 'orders';
``` 
*Столбец с наибольшим средним значением размера элемента `title`*
## Задача 3
Архитектор и администратор БД выяснили, что ваша таблица orders разрослась до невиданных размеров и поиск по ней 
занимает долгое время. Вам как успешному выпускнику курсов DevOps в Нетологии предложили провести разбиение таблицы на 2:
шардировать на orders_1 - price>499 и orders_2 - price<=499.  
Предложите SQL-транзакцию для проведения этой операции.  
*Создаю новую секционированную таблицу.* 
```sql
CREATE TABLE orders_partition (
             id integer NOT NULL,
             title character varying(80) NOT NULL,
             price integer DEFAULT 0
) PARTITION BY RANGE(price);
```
*Создаю секции.*
```sql
CREATE TABLE orders_1 PARTITION OF orders_partition FOR VALUES FROM (MINVALUE) TO (499);
```
```sql
CREATE TABLE orders_2 PARTITION OF orders_partition FOR VALUES FROM (499) TO (MAXVALUE);
```
*Копирую данные в новую таблицу*
```sql
INSERT INTO orders_partition(id, title, price)
SELECT * FROM orders;
```
*Проверка*
```sql
`SELECT * FROM orders_1;`
```
```text
 id |        title         | price 
----+----------------------+-------
  1 | War and peace        |   100
  3 | Adventure psql time  |   300
  4 | Server gravity falls |   300
  5 | Log gossips          |   123
(4 rows)
```
```sql
SELECT * FROM orders_2;
```
```text
 id |       title        | price 
----+--------------------+-------
  2 | My little database |   500
  6 | WAL never lies     |   900
  7 | Me and my bash-pet |   499
  8 | Dbiezdmin          |   501
(4 rows)
```
Можно ли было изначально исключить ручное разбиение при проектировании таблицы orders?  
*В этом случае нужно использовать секционирование с использованием наследования вместо декларативного секционирования*
## Задача 4
Используя утилиту `pg_dump`, создайте бекап БД `test_database`.
```shell
pg_dump -U postgres test_database > db.sql
```
Как бы вы доработали бэкап-файл, чтобы добавить уникальность значения столбца `title` для таблиц `test_database`?  
*Можно изменить таблицу `orders`. Добавить ограничение уникальности (UNIQUE) столбцу `title`*
```sql
CREATE TABLE public.orders (
    id integer NOT NULL,
    title character varying(80) UNIQUE NOT NULL,
    price integer DEFAULT 0
);
```
*Или в загруженной базе изменить столбец через ALTER TABLE*
```sql
ALTER TABLE ONLY public.orders ADD CONSTRAINT orders_title_key UNIQUE (title);
```
---
### Как сдавать задание
Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---