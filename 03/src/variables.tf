### Cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network & subnet name"
}

variable "default_disk_type" {
  type        = string
  default     = "network-hdd"
  description = "Тип диска по умолчанию: network-hdd, network-ssd, network-ssd-nonreplicated"
}

variable "ubuntu_2004_image_id" {
  type        = string
  description = "ID образа Ubuntu 20.04 LTS для ВМ"
  default     = "fd8hjrk74m4jvmvl5gi6"  # рабочий image_id
}

# Платформа по умолчанию
variable "default_platform_id" {
  type        = string
  default     = "standard-v1"
  description = "Тип платформы ВМ по умолчанию: standard-v1, burstable-v1 и др."
}

# Переменная для for_each-vm.tf — без zone и с опциональным image_id/platform_id
variable "each_vm" {
  type = list(object({
    vm_name      = string
    cpu          = number
    ram          = number
    disk_volume  = number
    platform_id  = optional(string)
    image_id     = optional(string)
  }))
  description = "Список ВМ для баз данных с разными параметрами"
  default = [
    {
      vm_name     = "main"
      cpu         = 4
      ram         = 4
      disk_volume = 20
      platform_id = "standard-v1"
    },
    {
      vm_name     = "replica"
      cpu         = 2
      ram         = 2
      disk_volume = 15
    }
  ]
}