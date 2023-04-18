variable  "bastion_service_subnet_name" {
  description = "Bastion service subnet name"
  default = "AzureBastionSubnet"
}

variable "bastion_service_subnet_cidr_address" {
  type = list
  description = "Bastion service cidr address"
  default = ["10.0.5.0/27"]
}
