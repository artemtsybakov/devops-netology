resource "yandex_compute_instance" "for_each-vm" {
  for_each = {for db in var.each_vm : db.vm_name => db}
  name = each.key
  resources {
    cores  = each.value.cpu
    core_fraction = each.value.fraction
    memory = each.value.ram
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size = each.value.disk_volume
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