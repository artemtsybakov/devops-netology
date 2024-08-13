# модуль создаем сети и подсети
module "vpc_prod" {
  source       = "./module/vpc"
  env_name     = "prod"
  subnets = [
    { zone = "ru-central1-a", cidr = "10.0.1.0/24" },
    { zone = "ru-central1-b", cidr = "10.0.2.0/24" },
    { zone = "ru-central1-c", cidr = "10.0.3.0/24" },
  ]
}
module "vpc_dev" {
  source   = "./module/vpc"
  env_name = "develop"
  subnets = [
    { zone = "ru-central1-a", cidr = "10.0.1.0/24" },
  ]
}
# модуль создаем ВМ marketing
module "marketing" {
  depends_on     = [module.vpc_dev]
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name       = "marketing"
  network_id     = module.vpc_dev.vpc_id
  subnet_zones   = ["ru-central1-a"]
  subnet_ids     = module.vpc_dev.subnet_ids
  instance_name  = "webs"
  instance_count = 1
  image_family   = "ubuntu-2004-lts"
  public_ip      = true

  labels = { owner= "marketing"}

  metadata = {
    user-data          = data.template_file.cloudinit.rendered #Для демонстрации №3
    serial-port-enable = 1
  }

}
# модуль создаем ВМ analytics
module "analytics" {
  depends_on     = [module.vpc_dev]
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name       = "analytics"
  network_id     = module.vpc_dev.vpc_id
  subnet_zones   = ["ru-central1-a"]
  subnet_ids     = module.vpc_dev.subnet_ids
  instance_name  = "webs"
  instance_count = 1
  image_family   = "ubuntu-2004-lts"
  public_ip      = true

  labels = { owner= "analytics"}

  metadata = {
    user-data          = data.template_file.cloudinit.rendered #Для демонстрации №3
    serial-port-enable = 1
  }

}
#Пример передачи cloud-config в ВМ для демонстрации №3
data "template_file" "cloudinit" {
  template = file("./cloud-init.yml")

  vars = {
    username = var.username
    ssh_public_key = file(var.ssh_public_key)
  }
}

