# inventory.tpl

=== IP-адреса и ресурсы инфраструктуры ===

[Виртуальная машина]
name = ${vm.name}
external_ip = ${vm.external_ip}
internal_ip = ${vm.internal_ip}
fqdn = ${vm.fqdn}

[База данных MySQL]
host_fqdn = ${mysql.fqdn}
internal_ip = ${mysql.internal_ip}

[Container Registry]
registry_id = ${registry.id}

[Сеть]
vpc_name = ${network.name}
subnet_cidr = ${subnet.cidr_blocks[0]}