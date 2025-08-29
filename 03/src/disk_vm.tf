# disk_vm.tf
resource "yandex_compute_disk" "additional" {
  count = var.storage_disk_count  

  name        = "disk-${count.index + 1}"
  folder_id   = var.folder_id
  zone        = var.default_zone
  type        = var.default_disk_type
  size        = var.storage_secondary_disk_size  
}

resource "yandex_compute_instance" "storage" {
  name        = "storage"
  folder_id   = var.folder_id
  zone        = var.default_zone
  platform_id = var.default_platform_id

  resources {
    cores         = var.storage_cpu
    memory        = var.storage_ram
    core_fraction = var.storage_core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu_2004.id
      type     = var.default_disk_type
      size     = var.storage_boot_disk_size  
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

  lifecycle {
    create_before_destroy = true
  }
}