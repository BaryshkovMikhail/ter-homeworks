# Образ Ubuntu 20.04 LTS
data "yandex_compute_image" "ubuntu_2004" {
  family    = "ubuntu-2004-lts"
  folder_id = "standard-images"
}