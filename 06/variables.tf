# Облако и каталог
variable "cloud_id" {
  type        = string
  description = "Идентификатор облака. https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "Идентификатор каталога. https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "service_account_key_file" {
  type        = string
  description = "Путь к JSON-файлу сервисного аккаунта"
  default     = "~/.authorized_key.json"
}

# Зона и сеть
variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "Зона доступности. https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "vpc_name" {
  type        = string
  default     = "app-network"
  description = "Имя VPC"
}

variable "subnet_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "CIDR подсети. https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

# Платформа и диски
variable "platform_id" {
  type        = string
  default     = "standard-v3"
  description = "Тип платформы ВМ"
}

variable "disk_type" {
  type        = string
  default     = "network-ssd"
  description = "Тип диска: network-hdd, network-ssd"
}

variable "vm_disk_size" {
  type        = number
  default     = 20
  description = "Размер диска ВМ (ГБ)"
}

# Параметры ВМ
variable "vm_cores" {
  type        = number
  default     = 2
  description = "Количество ядер ВМ"
}

variable "vm_memory" {
  type        = number
  default     = 2
  description = "Объём RAM (ГБ)"
}

# Порты
variable "ssh_port" {
  type        = number
  default     = 22
  description = "SSH порт"
}

variable "http_port" {
  type        = number
  default     = 80
  description = "HTTP порт"
}

variable "https_port" {
  type        = number
  default     = 443
  description = "HTTPS порт"
}

# CIDR для доступа
variable "ingress_cidr_blocks" {
  type        = list(string)
  default     = ["0.0.0.0/0"]
  description = "Доступные CIDR для входящих подключений"
}

variable "egress_cidr_blocks" {
  type        = list(string)
  default     = ["0.0.0.0/0"]
  description = "Доступные CIDR для исходящих подключений"
}

# Образ ОС
variable "image_id" {
  type        = string
  default     = "fd87va5cc00gaqnbvlks" # Ubuntu 20.04 LTS
  description = "ID образа ОС"
}

# Имя ВМ
variable "vm_name" {
  type        = string
  default     = "web-app-vm"
  description = "Имя виртуальной машины"
}

# Container Registry
variable "registry_name" {
  type        = string
  default     = "app-registry"
  description = "Имя Container Registry"
}

# База данных
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
  description = "Пароль от БД (передаётся через .tfvars)"
  sensitive   = true
}

# Приложение
variable "app_port" {
  type        = number
  default     = 80
  description = "Порт приложения внутри контейнера"
}