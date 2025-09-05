# inventory.tf

locals {
  vm = {
    name        = yandex_compute_instance.app_vm.name
    external_ip = yandex_compute_instance.app_vm.network_interface[0].nat_ip_address
    internal_ip = yandex_compute_instance.app_vm.network_interface[0].ip_address
    fqdn        = yandex_compute_instance.app_vm.fqdn
  }

  mysql = {
    fqdn        = yandex_mdb_mysql_cluster.db.host[0].fqdn
    internal_ip = yandex_mdb_mysql_cluster.db.host[0].fqdn
  }

  registry = {
    id = yandex_container_registry.main.id
  }

  network = {
    name = yandex_vpc_network.main.name
  }

  subnet = {
    cidr_blocks = yandex_vpc_subnet.main.v4_cidr_blocks
  }

  inventory_content = templatefile("${path.module}/inventory.tpl", {
    vm       = local.vm
    mysql    = local.mysql
    registry = local.registry
    network  = local.network
    subnet   = local.subnet
  })
}

resource "local_file" "inventory" {
  filename = "ips.txt"
  content  = local.inventory_content
}