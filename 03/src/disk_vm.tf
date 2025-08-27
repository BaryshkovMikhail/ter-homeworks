# disk_vm.tf
# Создание 3 одинаковых виртуальных дисков и ВМ "storage" с подключением дисков через dynamic secondary_disk

# Создание 3 дополнительных дисков по 1 Гб
resource "yandex_compute_disk" "additional" {
  count = 3

  name        = "disk-${count.index + 1}"
  folder_id   = var.folder_id
  zone        = var.default_zone
  type        = "network-hdd"
  size        = 1
}

# Создание одиночной ВМ с именем "storage"
resource "yandex_compute_instance" "storage" {
  name        = "storage"
  folder_id   = var.folder_id
  zone        = var.default_zone
  platform_id = "standard-v1"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd8hjrk74m4jvmvl5gi6"  # Ubuntu 20.04 LTS (из предыдущих заданий)
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

  # Подключение дополнительных дисков через dynamic и for_each
  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.additional[*].id
    content {
      disk_id = secondary_disk.value
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}