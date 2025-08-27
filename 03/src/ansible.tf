# ansible.tf
# Генерация динамического Ansible inventory-файла

locals {
  # Собираем данные о ВМ для передачи в шаблон

  # ВМ web-1, web-2 (созданы через count → это список)
  webservers = [
    for vm in yandex_compute_instance.web :
    {
      name        = vm.name
      external_ip = vm.network_interface[0].nat_ip_address
      fqdn        = vm.fqdn
    }
  ]

  # ВМ main, replica (созданы через for_each → это map)
  databases = [
    for name, vm in yandex_compute_instance.db :
    {
      name        = vm.name
      external_ip = vm.network_interface[0].nat_ip_address
      fqdn        = vm.fqdn
    }
  ]

  # Одиночная ВМ storage
  storage = [
    {
      name        = yandex_compute_instance.storage.name
      external_ip = yandex_compute_instance.storage.network_interface[0].nat_ip_address
      fqdn        = yandex_compute_instance.storage.fqdn
    }
  ]

  # Генерация содержимого inventory
  ansible_inventory = templatefile("${path.module}/inventory.tpl", {
    webservers = local.webservers
    databases  = local.databases
    storage    = local.storage
  })
}

# Запись inventory в файл
resource "local_file" "ansible_inventory" {
  filename = "inventory"
  content  = local.ansible_inventory
}