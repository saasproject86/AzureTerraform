# create Vnet
resource "azurerm_virtual_network" "saas-vnet" {
    name = "saas-vnet-1"
    address_space = [ "10.0.0.0/16" ]
    location = azurerm_resource_group.saas-rg-1.location
    resource_group_name = azurerm_resource_group.saas-rg-1.name
    tags = {
      "Name" = "saas-vnet-1"
      "Environment" = "development"
    }
}
# create Subnet
resource "azurerm_subnet" "saas-subnet-1" {
  name = "saas-subnet-1"
  resource_group_name = azurerm_resource_group.saas-rg-1.name
  virtual_network_name = azurerm_virtual_network.saas-vnet.name
  address_prefixes = [ "10.0.1.0/24" ]
}

resource "azurerm_subnet" "saas-subnet-2" {
  name = "saas-subnet-2"
  resource_group_name = azurerm_resource_group.saas-rg-1.name
  virtual_network_name = azurerm_virtual_network.saas-vnet.name
  address_prefixes = [ "10.0.2.0/24" ]
}

# create Public Ip
resource "azurerm_public_ip" "saas-public-ip" {
  name = "saas-public-ip"
  location = azurerm_resource_group.saas-rg-1.location
  resource_group_name = azurerm_resource_group.saas-rg-1.name
  allocation_method   = "Static"
  tags = {
    environment = "development"
  }
}

# creat network interface
resource "azurerm_network_interface" "saas-nic" {
  name                = "saas-nic"
  location = azurerm_resource_group.saas-rg-1.location
  resource_group_name = azurerm_resource_group.saas-rg-1.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.saas-subnet-1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.saas-public-ip.id
  }
}
