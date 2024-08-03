resource "local_file" "hosts_templatefile" {
  content = templatefile("${path.module}/hosts.tftpl",
    {
      webservers = yandex_compute_instance.count-vm
      dbservers = yandex_compute_instance.for_each-vm
      storageservers = yandex_compute_instance.storage
    } )
  filename = "${abspath(path.module)}/hosts.ini"
}