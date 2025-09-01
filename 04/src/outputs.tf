# outputs.tf
output "marketing_vm_fqdn" {
  value = module.marketing_vm.fqdn
}

output "analytics_vm_fqdn" {
  value = module.analytics_vm.fqdn
}

output "marketing_vm_public_ip" {
  value = module.marketing_vm.external_ip_address[0]
}

output "analytics_vm_public_ip" {
  value = module.analytics_vm.external_ip_address[0]
}