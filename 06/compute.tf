resource "yandex_compute_instance" "app_vm" {
  name        = var.vm_name
  zone        = var.default_zone
  platform_id = var.platform_id
  folder_id   = var.folder_id

  resources {
    cores  = var.vm_cores
    memory = var.vm_memory
  }

  boot_disk {
    initialize_params {
      image_id = var.image_id
      type     = var.disk_type
      size     = var.vm_disk_size
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.main.id
    security_group_ids = [yandex_vpc_security_group.app.id]
    nat                = true
  }

  metadata = {
    user-data = file("cloud-init.yaml")
  }
}