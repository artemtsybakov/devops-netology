# Домашнее задание к занятию «Продвинутые методы работы с Terraform»

### Задание 1
Cкриншот подключения к консоли и вывод команды ```sudo nginx -t```.

![console_analytics_vm.png](./png/console_analytics_vm.png)

![console_marketing_vm.png](./png/console_marketing_vm.png)

Cкриншот консоли ВМ yandex cloud с их метками.

![yc_console.png](./png/yc_console.png)

Cкриншот содержимого модуля.

![module_analytics.png](./png/module_analytics.png)

![module_marketing.png](./png/module_marketing.png)

### Задание 2

Добавил новы модуль. Модуль находится в папке module/vpc . Инициализация прошла успешно.

![module_init_vpc_dev.png](./png/module_init_vpc_dev.png)

После выполнения `terraform plan` получил вот такой [результат](./src/terraform_plan). Будет удалена 1 сеть, 2 подсети и 
изменены 2 ВМ.
После выполнения `terraform applay` получил ошибку `Quota limit vpc.networks.count exceeded` (Превышен лимит количества 
vpc). Удалил весь проект и снова создал. Все получилось.

Cкриншот информации из terraform console о своем модуле.

![module_vpc_dev.png](./png/module_vpc_dev.png)

Сгенерируйте документацию к модулю с помощью [terraform-docs](./src/module/vpc/README.md).

### Задание 3

1. Список ресурсов в стейте.

    ![terraform_state_list.png](./png/terraform_state_list.png)

2. Полностью удалите из стейта модуль vpc_dev.

   Import ресурсов происходит с указанием id ресурса. Сохранил id.
   
   ![module_ids.png](./png/module_ids.png)
   
   Удалил модуль.

   ![terraform_state_rm_module_vpc_dev.png](./png/terraform_state_rm_module_vpc_dev.png)

3. Удалил модуль vm.

   ![terraform_state_rm_module_analytics.png](./png/terraform_state_rm_module_analytics.png)

4. Импортируйте всё обратно. Проверьте terraform plan. Значимых(!!) изменений быть не должно. 

   После удаления state выглядит вот так.

   ![terraform_state_list_after.png](./png/terraform_state_list_after.png)

   Добавляю назад vpc.

   ![terraform_import_module_vpc_dev.png](./png/terraform_import_module_vpc_dev.png)

   Добавляю назад vm. id ресурса взял из облака.

   ![vm_id.png](./png/vm_id.png)
   
   ![terraform_import_module_analytics.png](./png/terraform_import_module_analytics.png)

   Проверка после импорта.
   
   ![terraform_plan_after_import.png](./png/terraform_plan_after_import.png)

### Задание 4

Код
```terraform
#создаем сеть
resource "yandex_vpc_network" "develop" {
  name = var.env_name
}

#создаем подсеть
resource "yandex_vpc_subnet" "develop" {
   #Преобразовываем list(object) в map(object) с которым работает for_each.
   #каждую подсеть мы идентифицируем уникальным ключом именем зоны.
  for_each = {for zone in var.subnets : zone.zone => zone }
  name           = "${var.env_name}-${each.key}"
  zone           = each.key
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = [each.value.cidr]
}
```


[terraform plan](./src/plan.md)

Скриншот из консоли.

![terraform_plan_vpc.png](./png/terraform_plan_vpc.png)

Скриншот из YC.

![terraform_vpc_yc.png](./png/terraform_vpc_yc.png)

![terraform_vpc_develop_subnet.png](./png/terraform_vpc_develop_subnet.png)

![terraform_vpc_prod_subnets.png](./png/terraform_vpc_prod_subnets.png)