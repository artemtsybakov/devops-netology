data "yandex_compute_image" "ubuntu" {
  family = var.image_family
}

#Пример передачи cloud-config в ВМ
data "template_file" "cloudinit" {
  template = file("./cloud-init.yml")

  vars = {
    username       = var.username
    ssh_public_key = file(var.ssh_public_key)
  }
}

resource "yandex_compute_instance" "clickhouse" {
  name     = var.vm_name_clickhouse
  hostname = var.vm_name_clickhouse
  resources {
    cores         = 2
    memory        = 1
    core_fraction = 5
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.clickhouse.id
    ip_address = var.clickhouseip
    nat       = true
  }
  scheduling_policy {
    preemptible = true
  }

  metadata = {
    user-data          = data.template_file.cloudinit.rendered
    serial-port-enable = 1
  }

}

resource "yandex_compute_instance" "vector" {
  name     = var.vm_name_vector
  hostname = var.vm_name_vector
  resources {
    cores         = 2
    memory        = 1
    core_fraction = 5
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.clickhouse.id
    nat       = true
    ip_address = var.vectorip
  }
  scheduling_policy {
    preemptible = true
  }

  metadata = {
    user-data          = data.template_file.cloudinit.rendered
    serial-port-enable = 1
  }

}

resource "yandex_compute_instance" "lighthouse" {
  name     = var.vm_name_lighthouse
  hostname = var.vm_name_lighthouse
  resources {
    cores         = 2
    memory        = 1
    core_fraction = 5
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.clickhouse.id
    ip_address = var.lighthouseip
    nat       = true
  }
  scheduling_policy {
    preemptible = true
  }

  metadata = {
    user-data          = data.template_file.cloudinit.rendered
    serial-port-enable = 1
  }

}