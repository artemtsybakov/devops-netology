## Задание

В клонированном репозитории:

1. Найдите полный хеш и комментарий коммита, хеш которого начинается на `aefea`.
```
Полный хэш aefead2207ef7e2aa5dc81a34aedf0cad4c3255
Комментарий Update CHANGELOG.md
```

2. Ответьте на вопросы.

* Какому тегу соответствует коммит `85024d3`?
```
С помощью команды git show 85024d3 можно посмотреть информацию о commit 
в которой так же указан tag этого commit "tag: v0.12.23"
```

* Сколько родителей у коммита `b8d720`? Напишите их хеши.
```
* Commit `b8d720` это merge commit и у он имеет 2 родителя.  

* b8d720f834 Merge pull request #23916 from hashicorp/cgriggs01-stable
|\
| * 9ea88f22fc add/update community provider listings
|/
*   56cd7859e0 Merge pull request #23857 from hashicorp/cgriggs01-stable
```

* Перечислите хеши и комментарии всех коммитов, которые были сделаны между тегами  v0.12.23 и v0.12.24.
```
Для просмотра диапазона можно использовать команду git log v0.12.23..v0.12.24 --oneline
33ff1c03bb (tag: v0.12.24) v0.12.24
b14b74c493 [Website] vmc provider links
3f235065b9 Update CHANGELOG.md
6ae64e247b registry: Fix panic when server is unreachable
5c619ca1ba website: Remove links to the getting started guide's old location
06275647e2 Update CHANGELOG.md
d5f9411f51 command: Fix bug when using terraform login on Windows
4b6d06cc5d Update CHANGELOG.md
dd01a35078 Update CHANGELOG.md
225466bc3e Cleanup after v0.12.23 release
```

* Найдите коммит, в котором была создана функция `func providerSource`, её определение в коде выглядит так: `func providerSource(...)` (вместо троеточия перечислены аргументы).

```commandline
Сначала нашел файл в котором есть эта функция.
$ git grep -n "func providerSource"
Для поиска по журналу commit использовал команду с названием функции и именем файла. 
$ git log -L:"func providerSource":provider_source.go
После просмотра commit, думаю что функция появилась в commit 8c928e83589d90a031f811fae52a81be7153e82f

diff --git a/provider_source.go b/provider_source.go
--- /dev/null
+++ b/provider_source.go
@@ -0,0 +19,5 @@
+func providerSource(services *disco.Disco) getproviders.Source {
+       // We're not yet using the CLI config here because we've not implemented
+       // yet the new configuration constructs to customize provider search
+       // locations. That'll come later.
+       // For now, we have a fixed set of search directories:

```

* Найдите все коммиты, в которых была изменена функция `globalPluginDirs`.

```commandline
$ git log -S"globalPluginDirs" --oneline
65c4ba7363 Remove terraform binary
125eb51dc4 Remove accidentally-committed binary
22c121df86 Bump compatibility version to 1.3.0 for terraform core release (#30988)
7c7e5d8f0a Don't show data while input if sensitive
35a058fb3d main: configure credentials from the CLI config file
c0b1761096 prevent log output during init
8364383c35 Push plugin discovery down into command package
```

* Кто автор функции `synchronizedWriters`? 

```Martin Atkins <mart@degeneration.co.uk>```

*В качестве решения ответьте на вопросы и опишите, как были получены эти ответы.*