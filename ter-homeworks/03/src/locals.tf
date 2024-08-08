locals {
  vm_ssh_key = file("~/.ssh/yandexcloud.pub")
  disk_vm_disk_id = tolist(yandex_compute_disk.disk_vm[*].id)
  output_count-vm = [ for vm in yandex_compute_instance.count-vm[*]: {
    name = vm.name
    id = vm.id
    fqdn = vm.fqdn
  }]
  output_for_each-vm = [ for vm in yandex_compute_instance.for_each-vm: {
    name = vm.name
    id = vm.id
    fqdn = vm.fqdn
  }]
  output_storage = [ for vm in [yandex_compute_instance.storage]: {
    name = vm.name
    id = vm.id
    fqdn = vm.fqdn
  }]
}