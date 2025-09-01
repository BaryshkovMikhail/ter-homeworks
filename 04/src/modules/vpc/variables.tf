# modules/vpc/variables.tf
variable "env_name" {
  type        = string
  description = "Name of the VPC network"
}

variable "zone" {
  type        = string
  description = "Availability zone for the subnet"
}

variable "cidr" {
  type        = string
  description = "CIDR block for the subnet, e.g. 10.0.1.0/24"
}