# common variables
business_division = "hr"
environment = "dev"
resource_group_name = "saas-rg-1"
resource_group_location = "australiasoutheast"

# vnet
vnet_name = "saas-vnet-1"
vnet_cidr = ["10.0.0.0/16"]

# subnet
app_subnet_name = "saas-app-subnet"
app_subnet_cidr = ["10.0.1.0/24"]

web_subnet_name = "saas-web-subnet"
web_subnet_cidr = ["10.0.2.0/24"]

bastion_subnet_name = "saas-bastion-subnet"
bastion_subnet_cidr = ["10.0.3.0/24"]

db_subnet_name = "saas-db-subnet"
db_subnet_cidr = ["10.0.4.0/24"]

# Linux VM
linux_vm_size = "Standard_DS1_v2"