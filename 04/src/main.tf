# main.tf

module "vpc_dev" {
  source = "./modules/vpc"

  env_name = var.vpc_name
  zone     = var.default_zone
  cidr     = "10.0.1.0/24"
}

# ВМ для marketing
module "marketing_vm" {
  source = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"

  providers = {
    yandex = yandex  # ← Явно передаём провайдер из root module
  }

  env_name       = "marketing"
  network_id     = module.vpc_dev.network_id
  subnet_zones   = [module.vpc_dev.subnet_zone]
  subnet_ids     = [module.vpc_dev.subnet_id]
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
  source = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"

  providers = {
    yandex = yandex
  }

  env_name       = "analytics"
  network_id     = module.vpc_dev.network_id
  subnet_zones   = [module.vpc_dev.subnet_zone]
  subnet_ids     = [module.vpc_dev.subnet_id]
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