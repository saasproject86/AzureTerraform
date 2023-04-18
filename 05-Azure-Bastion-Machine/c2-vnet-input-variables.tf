# Vnet variables 
variable "vnet_name" {
  type = string
  description = "Vnet Name"
}

variable "vnet_cidr" {
  type = list(string)
  description = "Vnet CIDR block"
  default = ["10.0.0.0/16"]
}

# Subnet variables 
variable "app_subnet_name" {
  type = string
  description = "App subnet name"
}

variable "app_subnet_cidr" {
  type = list
  description = "App subnet name"
}


variable "web_subnet_name" {
  type = string
  description = "Web subnet name"
}

variable "web_subnet_cidr" {
  type = list
  description = "Web subnet name"
}

variable "bastion_subnet_name" {
  type = string
  description = "Bastion subnet name"
}

variable "bastion_subnet_cidr" {
  type = list
  description = "Bastion subnet name"
}

variable "db_subnet_name" {
  type = string
  description = "DB subnet name"
}
variable "db_subnet_cidr" {
  type = list
  description = "DB subnet name"
}
