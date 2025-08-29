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

# Переменная для for_each-vm.tf — ВМ main и replica
variable "each_vm" {
  type = list(object({
    vm_name      = string
    cpu          = number
    ram          = number
    disk_volume  = number
    platform_id  = optional(string, "standard-v1")
    image_id     = optional(string)
  }))
  description = "Список ВМ для баз данных с разными параметрами"
  default = [
    {
      vm_name     = "main"
      cpu         = 4
      ram         = 4
      disk_volume = 20
    },
    {
      vm_name     = "replica"
      cpu         = 2
      ram         = 2
      disk_volume = 15
    }
  ]
}

# Общие параметры
variable "default_platform_id" {
  type        = string
  default     = "standard-v1"
  description = "Тип платформы ВМ по умолчанию"
}

variable "default_disk_type" {
  type        = string
  default     = "network-hdd"
  description = "Тип диска: network-hdd, network-ssd"
}

# Параметры ВМ web
variable "web_count" {
  type        = number
  default     = 2
  description = "Количество ВМ web-серверов (требуется ровно 2)"
}

variable "web_cpu" {
  type        = number
  default     = 2
  description = "CPU для ВМ web"
}

variable "web_ram" {
  type        = number
  default     = 2
  description = "RAM для ВМ web"
}

variable "web_core_fraction" {
  type        = number
  default     = 5
  description = "Core fraction для ВМ web"
}

variable "web_boot_disk_size" {
  type        = number
  default     = 10
  description = "Размер загрузочного диска для ВМ web в Гб"
}

# Параметры ВМ storage
variable "storage_cpu" {
  type        = number
  default     = 2
  description = "CPU для ВМ storage"
}

variable "storage_ram" {
  type        = number
  default     = 2
  description = "RAM для ВМ storage"
}

variable "storage_core_fraction" {
  type        = number
  default     = 5
  description = "Core fraction для ВМ storage"
}

variable "storage_boot_disk_size" {
  type        = number
  default     = 10
  description = "Размер загрузочного диска для ВМ storage в Гб"
}

variable "storage_disk_count" {
  type        = number
  default     = 3
  description = "Количество дополнительных дисков для ВМ storage"
}

variable "storage_secondary_disk_size" {
  type        = number
  default     = 1
  description = "Размер каждого дополнительного диска для storage в Гб"
}

# Порты в security group
variable "ssh_port" {
  type        = number
  default     = 22
  description = "Порт для SSH"
}

variable "http_port" {
  type        = number
  default     = 80
  description = "Порт для HTTP"
}

variable "https_port" {
  type        = number
  default     = 443
  description = "Порт для HTTPS"
}

# CIDR для входящих и исходящих правил
variable "ingress_cidr_blocks" {
  type        = list(string)
  default     = ["0.0.0.0/0"]
  description = "Список CIDR для разрешённого входящего трафика"
}

variable "egress_cidr_blocks" {
  type        = list(string)
  default     = ["0.0.0.0/0"]
  description = "Список CIDR для разрешённого исходящего трафика"
}

# Порты для исходящего трафика
variable "egress_from_port" {
  type        = number
  default     = 0
  description = "Начальный порт для исходящего трафика"
}

variable "egress_to_port" {
  type        = number
  default     = 65535
  description = "Конечный порт для исходящего трафика"
}