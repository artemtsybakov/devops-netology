output "vm_external_ip_address" {
  value = [
    { web = ["instance name ${yandex_compute_instance.platform.name}",
      "externa ip addr ${yandex_compute_instance.platform.network_interface[0].nat_ip_address}",
      "FQDN ${yandex_compute_instance.platform.fqdn}"
    ] },
    { db = ["instance name ${yandex_compute_instance.platform_db.name}",
      "externa ip addr ${yandex_compute_instance.platform_db.network_interface[0].nat_ip_address}",
      "FQDN ${yandex_compute_instance.platform_db.fqdn}"
    ]
    }
    ]
  description="External ip address vms"
}
