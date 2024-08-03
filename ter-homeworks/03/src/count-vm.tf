resource "yandex_compute_instance" "count-vm" {
  depends_on = [yandex_compute_instance.for_each-vm]
  count = length(var.web_servers)
  name =  join("", [var.count-vm_name, count.index+1])
  hostname = join("", [var.count-vm_name, count.index+1])
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
    security_group_ids = [yandex_vpc_security_group.example.id]
    nat       = true
  }
  scheduling_policy {
    preemptible = true
  }
  metadata = {
    ssh-keys           = local.vm_ssh_key
  }
}