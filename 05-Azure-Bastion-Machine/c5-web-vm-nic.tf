# nic
resource "azurerm_network_interface" "web-linux-vm-nic" {
  name                =  "${local.resource_name_prefix}-web-linux-vm-nic"
  location = azurerm_resource_group.saas-rg.location
  resource_group_name = azurerm_resource_group.saas-rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.saas-web-subnet.id
    private_ip_address_allocation = "Dynamic"
    # public_ip_address_id = azurerm_public_ip.web-vm-public-ip.id
  }
}
