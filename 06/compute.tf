# compute.tf

data "template_file" "cloud_init" {
  template = file("cloud-init.yaml")

  vars = {
    registry_id = yandex_container_registry.main.id
    db_host     = yandex_mdb_mysql_cluster.db.host[0].fqdn
    db_user     = var.db_user
    db_name     = var.db_name
  }
}

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
      image_id = data.yandex_compute_image.ubuntu_2004.id
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
    ssh-keys = "ubuntu:${local.ssh_public_key}"
    user-data   = data.template_file.cloud_init.rendered
  }
}