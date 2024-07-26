resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "develop_db" {
  name           = var.vpc_name_db
  zone           = var.vm_db_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr_db
}

data "yandex_compute_image" "ubuntu" {
  family = var.image_family
}
resource "yandex_compute_instance" "platform_db" {
  name        = local.vm_db_name
  platform_id = var.vm_db_platform_id
  zone = var.vm_db_zone
  resources {
    cores         = var.vm_resources["db"]["cores"]
    memory        = var.vm_resources["db"]["memory"]
    core_fraction = var.vm_resources["db"]["core_fraction"]
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop_db.id
    nat       = true
  }

  metadata = {
    serial-port-enable = var.metadata["serial-port-enable"]
    ssh-keys           = var.metadata["ssh-keys"]
  }
}