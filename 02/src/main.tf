# VPC Network
resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}

# Подсеть в зоне ru-central1-a
resource "yandex_vpc_subnet" "develop_a" {
  name           = "${var.vpc_name}-subnet-a"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}

# Подсеть в зоне ru-central1-b
resource "yandex_vpc_subnet" "develop_b" {
  name           = "${var.vpc_name}-subnet-b"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = ["10.0.2.0/24"] # Второй диапазон IP
}

# Источник образа Ubuntu
data "yandex_compute_image" "ubuntu" {
  family = var.vm_web_image_family
}

# Первая ВМ: Web
resource "yandex_compute_instance" "web" {
  name        = local.vm_web_name
  platform_id = var.vm_web_platform_id

  resources {
    cores         = var.vm_web_cores
    memory        = var.vm_web_memory
    core_fraction = var.vm_web_core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }

  scheduling_policy {
    preemptible = var.vm_web_preemptible
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop_a.id
    nat       = true
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:${file("~/.ssh/woland2.pub")}"
  }
}

# Вторая ВМ: DB
resource "yandex_compute_instance" "db" {
  name        = local.vm_db_name
  platform_id = var.vm_db_platform_id

  resources {
    cores         = var.vm_db_cores
    memory        = var.vm_db_memory
    core_fraction = var.vm_db_core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }

  scheduling_policy {
    preemptible = var.vm_db_preemptible
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop_b.id
    nat       = true
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:${file("~/.ssh/woland2.pub")}"
  }

  zone = var.vm_db_zone
}