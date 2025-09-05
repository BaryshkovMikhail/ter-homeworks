# outputs.tf

output "vm_external_ip" {
  description = "Внешний IP-адрес ВМ с приложением"
  value       = yandex_compute_instance.app_vm.network_interface[0].nat_ip_address
}

output "vm_internal_ip" {
  description = "Внутренний IP-адрес ВМ"
  value       = yandex_compute_instance.app_vm.network_interface[0].ip_address
}

output "mysql_internal_ip" {
  description = "FQDN MySQL хоста (разрешается во внутренний IP)"
  value       = yandex_mdb_mysql_cluster.db.host[0].fqdn
}

output "registry_id" {
  description = "ID Container Registry"
  value       = yandex_container_registry.main.id
}