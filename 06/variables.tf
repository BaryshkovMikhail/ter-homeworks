variable "cloud_id" {
  type        = string
  description = "Идентификатор облака"
}

variable "iam_token" {
  type        = string
  description = "IAM-токен для временного доступа"
  sensitive   = true
}

variable "folder_id" {
  type        = string
  description = "Идентификатор каталога"
}

variable "service_account_key_file" {
  type        = string
  description = "Путь к JSON-файлу сервисного аккаунта"
  default     = "/home/woland/.authorized_key.json"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "Зона доступности"
}

variable "vpc_name" {
  type        = string
  default     = "app-network"
  description = "Имя VPC"
}

variable "subnet_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "CIDR подсети"
}

variable "platform_id" {
  type        = string
  default     = "standard-v3"
  description = "Тип платформы ВМ"
}

variable "disk_type" {
  type        = string
  default     = "network-ssd"
  description = "Тип диска: network-ssd, network-hdd"
}

variable "vm_disk_size" {
  type        = number
  default     = 20
  description = "Размер диска ВМ (ГБ)"
}

variable "vm_cores" {
  type        = number
  default     = 2
  description = "Количество ядер"
}

variable "vm_memory" {
  type        = number
  default     = 2
  description = "Объём RAM (ГБ)"
}

variable "image_id" {
  type        = string
  default     = "fd87va5cc00gaqnbvlks" # Ubuntu 20.04 LTS
  description = "ID образа ОС"
}

variable "vm_name" {
  type        = string
  default     = "web-app-vm"
  description = "Имя ВМ"
}

variable "registry_name" {
  type        = string
  default     = "app-registry"
  description = "Имя Container Registry"
}

variable "db_name" {
  type        = string
  default     = "app_db"
  description = "Имя базы данных"
}

variable "db_user" {
  type        = string
  default     = "app_user"
  description = "Имя пользователя БД"
}

variable "db_password_secret_name" {
  type        = string
  default     = "db-password-secret"
  description = "Имя секрета в LockBox"
}

variable "db_password" {
  type        = string
  description = "Пароль от БД"
  sensitive   = true
}

variable "security_group_ingress" {
  description = "Правила ingress для security group"
  type = list(object({
    protocol       = string
    description    = string
    v4_cidr_blocks = list(string)
    port           = optional(number)
    from_port      = optional(number)
    to_port        = optional(number)
  }))
}

variable "security_group_egress" {
  description = "Правила egress для security group"
  type = list(object({
    protocol       = string
    description    = string
    v4_cidr_blocks = list(string)
    port           = optional(number)
    from_port      = optional(number)
    to_port        = optional(number)
  }))
}