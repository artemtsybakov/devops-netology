# Домашнее задание к занятию 5. «Практическое применение Docker»

### Инструкция к выполнению

1. Для выполнения заданий обязательно ознакомьтесь с [инструкцией](https://github.com/netology-code/devops-materials/blob/master/cloudwork.MD) по экономии облачных ресурсов. Это нужно, чтобы не расходовать средства, полученные в результате использования промокода.
2. **Своё решение к задачам оформите в вашем GitHub репозитории.**
3. В личном кабинете отправьте на проверку ссылку на .md-файл в вашем репозитории.
4. Сопроводите ответ необходимыми скриншотами.

---
## Примечание: Ознакомьтесь со схемой виртуального стенда [по ссылке](https://github.com/netology-code/shvirtd-example-python/blob/main/schema.pdf)

## Задача 0
У меня не установлен старый `docker-compose`.
```text
/mnt/WorkSSD/git/devops-netology/shvirtd/05-virt-03-docker-intro git:[main]
docker-compose --version
Команда «docker-compose» не найдена, но может быть установлена с помощью:
sudo snap install docker          # version 24.0.5, or
sudo apt  install docker-compose  # version 1.29.2-1
См. 'snap info docker', чтобы посмотреть дополнительные версии.
```
## Задача 1
```text
git clone https://github.com/artemtsybakov/shvirtd-example-python.git
Клонирование в «shvirtd-example-python»...
remote: Enumerating objects: 53, done.
remote: Counting objects: 100% (25/25), done.
remote: Compressing objects: 100% (15/15), done.
remote: Total 53 (delta 15), reused 11 (delta 8), pack-reused 28
Получение объектов: 100% (53/53), 44.64 КиБ | 457.00 КиБ/с, готово.
Определение изменений: 100% (16/16), готово.
```

## Задача 6.1
sudo docker pull hashicorp/terraform:latest
sudo docker run -ti --rm -v /var/run/docker.sock:/var/run/docker.sock wagoodman/dive hashicorp/terraform
sudo docker image  save -o  /tmp/image.tar.gz hashicorp/terraform
cd /tmp/
sudo tar xf /tmp/image.tar.gz
cd blobs/sha256
sudo tar xf 4dcbcdcfdb7ea3f99552522f11af8c3e79c9c6423d85e40ddc627ca379af9c3e
ls -la bin/terraform 


## Задача 6.1
sudo docker cp 461faec92273:/bin/terraform .