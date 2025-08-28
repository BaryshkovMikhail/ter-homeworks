# data.tf
# Получение последнего образа Ubuntu 20.04 LTS из семейства

data "yandex_compute_image" "ubuntu_2004" {
  family    = "ubuntu-2004-lts-oslogin"
  folder_id = "standard-images"
}