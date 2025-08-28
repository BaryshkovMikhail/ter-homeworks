# disk_vm.tf
# Создание 3 дисков и ВМ storage с подключением через dynamic secondary_disk

resource "yandex_compute_disk" "additional" {
  count = 3

  name        = "disk-${count.index + 1}"
  folder_id   = var.folder_id
  zone        = var.default_zone
  type        = var.default_disk_type
  size        = 1
}

resource "yandex_compute_instance" "storage" {
  name        = "storage"
  folder_id   = var.folder_id
  zone        = var.default_zone
  platform_id = var.default_platform_id

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu_2004.id
      #image_id = var.ubuntu_2004_image_id
      type     = var.default_disk_type
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

  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.additional[*].id
    content {
      disk_id = secondary_disk.value
    }
  }
  # Явная зависимость от data
  depends_on = [
    data.yandex_compute_image.ubuntu_2004
  ]

  lifecycle {
    create_before_destroy = true
  }
}