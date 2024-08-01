resource "yandex_compute_instance" "for_each-vm" {
  for_each = var.each_vm
  name = each.value
  resources {
    cores  = each.value
    memory = each.value
  }

}