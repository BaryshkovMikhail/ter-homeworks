# for_each-vm.tf
# Создание ВМ main и replica с разными параметрами через for_each

resource "yandex_compute_instance" "db" {
  for_each = { for vm in var.each_vm : vm.vm_name => vm }

  name        = each.value.vm_name
  zone        = var.default_zone          # Централизованно из variables.tf
  folder_id   = var.folder_id
  platform_id = lookup(each.value, "platform_id", "standard-v1")

  resources {
    cores  = each.value.cpu
    memory = each.value.ram
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = lookup(each.value, "image_id", "fd8hjrk74m4jvmvl5gi6")
      type     = "network-hdd"
      size     = each.value.disk_volume
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.develop.id
    security_group_ids = [yandex_vpc_security_group.example.id]
    nat                = true
  }

  metadata = {
    ssh-keys = "ubuntu:${local.ssh_public_key}"
  }

  lifecycle {
    create_before_destroy = true
  }
}