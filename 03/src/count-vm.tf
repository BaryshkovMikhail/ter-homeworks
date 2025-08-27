# count-vm.tf
# Создание ВМ web-1 и web-2 через count

resource "yandex_compute_instance" "web" {
  count = 2

  name        = "web-${count.index + 1}"
  zone        = var.default_zone
  folder_id   = var.folder_id
  platform_id = "standard-v1"

  resources {
    cores         = 2
    memory        = 2
    core_fraction = 5
  }

  boot_disk {
    initialize_params {
      image_id = "fd8hjrk74m4jvmvl5gi6"
      type     = "network-hdd"
      size     = 10
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

  # Зависимость: web создаются ПОСЛЕ db
  depends_on = [
    yandex_compute_instance.db
  ]

  lifecycle {
    create_before_destroy = true
  }
}