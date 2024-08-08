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
  vpc1 = {
  "network_id" = "enp7i560tb28nageq0cc"
  "subnet_ids" = [
    "e9b0le401619ngf4h68n",
    "e2lbar6u8b2ftd7f5hia",
    "b0ca48coorjjq93u36pl",
    "fl8ner8rjsio6rcpcf0h",
  ]
  "subnet_zones" = [
    "ru-central1-a",
    "ru-central1-b",
    "ru-central1-c",
    "ru-central1-d",
  ]
}
}