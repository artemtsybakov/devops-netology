resource "yandex_compute_instance" "count-vm" {
  count = length(var.web_servers)
  name = "web-server-${count.index+1}"
  resources {
    cores         = var.vm_resources.web.cores
    memory        = var.vm_resources.web.memory
    core_fraction = var.vm_resources.web.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    security_group_ids = ["example_dynamic"]
    nat       = true
  }
  scheduling_policy {
    preemptible = true
  }
  metadata = {
    ssh-keys           = local.vm_ssh_key
  }
}