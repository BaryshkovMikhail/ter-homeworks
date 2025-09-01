# main.tf

resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}

resource "yandex_vpc_subnet" "marketing" {
  name           = "${var.vpc_name}-marketing"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = ["10.0.10.0/24"]
}

resource "yandex_vpc_subnet" "analytics" {
  name           = "${var.vpc_name}-analytics"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = ["10.0.20.0/24"]
}

# ВМ для marketing
module "marketing_vm" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name       = "marketing"
  network_id     = yandex_vpc_network.develop.id
  subnet_zones   = ["ru-central1-a"]
  subnet_ids     = [yandex_vpc_subnet.marketing.id]
  instance_name  = "marketing-vm"
  instance_count = 1
  image_family   = "ubuntu-2004-lts"
  public_ip      = true

  labels = {
    project = "marketing"
    owner   = "m.baryshkov"
  }

  metadata = {
    user-data          = templatefile("${path.module}/cloud-init.yml", { ssh_key = var.vms_ssh_root_key })
    serial-port-enable = 1
  }
}

# ВМ для analytics
module "analytics_vm" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name       = "analytics"
  network_id     = yandex_vpc_network.develop.id
  subnet_zones   = ["ru-central1-b"]
  subnet_ids     = [yandex_vpc_subnet.analytics.id]
  instance_name  = "analytics-vm"
  instance_count = 1
  image_family   = "ubuntu-2004-lts"
  public_ip      = true

  labels = {
    project = "analytics"
    owner   = "m.baryshkov"
  }

  metadata = {
    user-data          = templatefile("${path.module}/cloud-init.yml", { ssh_key = var.vms_ssh_root_key })
    serial-port-enable = 1
  }
}