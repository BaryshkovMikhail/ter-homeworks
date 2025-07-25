output "vm_instances_info" {
  value = {
    web = {
      instance_name = yandex_compute_instance.web.name
      external_ip   = yandex_compute_instance.web.network_interface[0].nat_ip_address
      internal_ip   = yandex_compute_instance.web.network_interface[0].ip_address
    },
    db = {
      instance_name = yandex_compute_instance.db.name
      external_ip   = yandex_compute_instance.db.network_interface[0].nat_ip_address
      internal_ip   = yandex_compute_instance.db.network_interface[0].ip_address
    }
  }
}