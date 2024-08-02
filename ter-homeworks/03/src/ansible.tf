# resource "local_file" "hosts_templatefile" {
#   content = templatefile("${path.module}/hosts.tftpl",
#
#   { webservers = yandex_compute_instance.example })
#
#   filename = "${abspath(path.module)}/hosts.ini"
# }