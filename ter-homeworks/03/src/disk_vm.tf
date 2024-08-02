resource "yandex_compute_disk" "disk_vm" {
  count = length(var.storage_disk)
  size  = var.storage_disk[count.index]
}

resource "yandex_compute_instance" "storage" {
  depends_on = [yandex_compute_disk.disk_vm]
  name = "storage"
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
  dynamic "secondary_disk" {
    for_each = toset(local.disk_vm_disk_id)
    content {
      disk_id = secondary_disk.value
    }
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }
  scheduling_policy {
    preemptible = true
  }
  metadata = {
    ssh-keys           = local.vm_ssh_key
  }
}