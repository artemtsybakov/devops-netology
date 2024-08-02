locals {
  vm_ssh_key = file("~/.ssh/id_ed25519.pub")
  disk_vm_disk_id = tolist(yandex_compute_disk.disk_vm[*].id)
}