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
