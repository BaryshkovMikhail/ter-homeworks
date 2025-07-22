### Cloud vars

variable "cloud_id" {
  type        = string
  description = "Cloud ID in Yandex Cloud"
}

variable "folder_id" {
  type        = string
  description = "Folder ID in Yandex Cloud"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
}

variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "vpc_name" {
  type        = string
  default     = "develop"
}

### SSH vars

variable "vms_ssh_root_key" {
  type        = string
  default     = "~/.ssh/woland2.pub"
  description = "SSH public key for root access"
}

### VM resources (combined)

variable "vms_resources" {
  type = map(object({
    cores         = number
    memory        = number
    core_fraction = number
    hdd_size      = number
    hdd_type      = string
  }))
  default = {
    web = {
      cores         = 2
      memory        = 2
      core_fraction = 5
      hdd_size      = 10
      hdd_type      = "network-hdd"
    },
    db = {
      cores         = 2
      memory        = 2
      core_fraction = 20
      hdd_size      = 10
      hdd_type      = "network-hdd"
    }
  }
}

### Metadata (общий для всех ВМ)

variable "metadata" {
  type = object({
    serial-port-enable = number
    ssh-keys           = string
  })
  default = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:" # Только префикс! Ключ добавим в main.tf
  }
}

### Устаревшие переменные (закомментированы)

# variable "vm_web_cores" {
#   type    = number
#   default = 1
# }
#
# variable "vm_web_memory" {
#   type    = number
#   default = 2
# }
#
# variable "vm_web_core_fraction" {
#   type    = number
#   default = 5
# }
#
# variable "vm_db_cores" {
#   type    = number
#   default = 2
# }
#
# variable "vm_db_memory" {
#   type    = number
#   default = 2
# }
#
# variable "vm_db_core_fraction" {
#   type    = number
#   default = 20
# }