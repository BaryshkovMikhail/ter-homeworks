# ansible.tf
locals {
  webservers = [
    for vm in yandex_compute_instance.web :
    {
      name        = vm.name
      external_ip = vm.network_interface[0].nat_ip_address
      fqdn        = vm.fqdn
    }
  ]

  databases = [
    for name, vm in yandex_compute_instance.db :
    {
      name        = vm.name
      external_ip = vm.network_interface[0].nat_ip_address
      fqdn        = vm.fqdn
    }
  ]

  storage = [
    {
      name        = yandex_compute_instance.storage.name
      external_ip = yandex_compute_instance.storage.network_interface[0].nat_ip_address
      fqdn        = yandex_compute_instance.storage.fqdn
    }
  ]

  ansible_inventory = templatefile("${path.module}/inventory.tpl", {
    webservers = local.webservers
    databases  = local.databases
    storage    = local.storage
  })
}

resource "local_file" "ansible_inventory" {
  filename = "inventory"
  content  = local.ansible_inventory
}