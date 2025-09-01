# modules/vpc/outputs.tf
output "network_id" {
  value = yandex_vpc_network.this.id
}

output "subnet_id" {
  value = yandex_vpc_subnet.this.id
}

output "subnet_zone" {
  value = yandex_vpc_subnet.this.zone
}

output "subnet_cidr" {
  value = yandex_vpc_subnet.this.v4_cidr_blocks[0]
}