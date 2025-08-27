# count-vm.tf
# Создание двух одинаковых ВМ: web-1 и web-2 с помощью мета-аргумента count
# Используется общая группа безопасности и SSH-ключ из файла

locals {
  # Чтение публичного SSH-ключа для доступа к ВМ
  ssh_public_key = file("~/.ssh/id_rsa.pub")
}

resource "yandex_compute_instance" "web" {
  count = 2

  name        = "web-${count.index + 1}"  # Генерирует имена: web-1, web-2
  zone        = var.default_zone
  folder_id   = var.folder_id
  platform_id = "standard-v1"

  # Минимальные параметры ресурсов
  resources {
    cores         = 2
    memory        = 2
    core_fraction = 5
  }

  # Загрузочный диск: минимальный размер, тип network-hdd
  boot_disk {
    initialize_params {
      image_id = "fd87va5cc00gaqnb7gpi"  # Ubuntu 20.04 LTS (образ в Yandex Cloud)
      type     = "network-hdd"
      size     = 10
    }
  }

  # Сетевой интерфейс: подключение к подсети и группе безопасности
  network_interface {
    subnet_id          = yandex_vpc_subnet.develop.id
    security_group_ids = [yandex_vpc_security_group.example.id]
    nat                = true  # Разрешаем исходящий доступ в интернет
  }

  # Метаданные: передача SSH-ключа для пользователя ubuntu
  metadata = {
    ssh-keys = "ubuntu:${local.ssh_public_key}"
  }

  # Обеспечение корректного порядка: создавать ПОСЛЕ ВМ из for_each-vm.tf
  depends_on = [
    yandex_compute_instance.db
  ]

  # Защита от немедленного уничтожения при изменениях
  lifecycle {
    create_before_destroy = true
  }
}