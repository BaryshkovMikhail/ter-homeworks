###cloud vars
#variable "token" {
#  type        = string
#  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
#}

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

#variable "default_cidr" {
#  type        = list(string)
#  default     = ["10.0.1.0/24"]
#  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
#}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}

###common vars
variable "vms_ssh_root_key" {
  type        = string
  default     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF5fK+g2KVk8M7DcnxENYKsmnx4J4ryLHjCJeMwjf3fZ m.baryshkov@mail.ru"
  description = "ssh-keygen -t ed25519"
}

variable "ip_address" {
  type        = string
  description = "IP-адрес"

  validation {
    condition = can(regex("^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$", var.ip_address))
    error_message = "Значение '${var.ip_address}' не является валидным IPv4-адресом."
  }

  default = "192.168.0.1"           # ✅ валидный
  #default = "1920.1680.0.1"       # ❌ невалидный
}

variable "ip_list" {
  type        = list(string)
  description = "Список IP-адресов"

  validation {
    condition = alltrue([
      for ip in var.ip_list : can(regex("^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$", ip))
    ])
    error_message = "Один или несколько IP-адресов в списке невалидны. Убедитесь, что все адреса соответствуют формату x.x.x.x (0-255)."
  }

  default = ["192.168.0.1", "1.1.1.1", "127.0.0.1"]     # ✅ валидный
  #default = ["192.168.0.1", "1.1.1.1", "1270.0.0.1"]  # ❌ с ошибкой
}

###example vm_web var
#variable "vm_web_name" {
#  type        = string
#  default     = "netology-develop-platform-web"
#  description = "example vm_web_ prefix"
#}

###example vm_db var
#variable "vm_db_name" {
#  type        = string
#  default     = "netology-develop-platform-db"
#  description = "example vm_db_ prefix"
#}
