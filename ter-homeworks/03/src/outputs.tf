output "count-vm" {
  value = [ for vm in yandex_compute_instance.count-vm[*]: {
    name = vm.name
    id = vm.id
    fqdn = vm.fqdn
  }]
}

output "for_each" {
  value = [ for vm in yandex_compute_instance.for_each-vm: {
    name = vm.name
    id = vm.id
    fqdn = vm.fqdn
  }]
}