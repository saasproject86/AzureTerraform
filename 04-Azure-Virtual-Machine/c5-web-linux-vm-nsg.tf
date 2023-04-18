# nsg
resource "azurerm_network_security_group" "web-linux-vm-nsg" {
  name                = "${local.resource_name_prefix}-web-linux-nsg"
  location            = azurerm_resource_group.saas-rg.location
  resource_group_name = azurerm_resource_group.saas-rg.name
  tags = local.common_tags
}

# nsg rules
resource "azurerm_network_security_rule" "web-linux-vm-nsg-inbound" {
  for_each = {
    "100" : "80", # If the key starts with a number, you must use the colon syntax ":" instead of "="
    "110" : "443",
    "120" : "22"
  }
  name                        = "Rule-Port-${each.value}"
  priority                    = each.key
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = each.value
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.saas-rg.name
  network_security_group_name = azurerm_network_security_group.web-linux-vm-nsg.name
}

#nsg association
resource "azurerm_network_interface_security_group_association" "web-linux-vm-nsg-association" {
  depends_on = [
    azurerm_network_security_rule.web-linux-vm-nsg-inbound
  ]
  network_interface_id = azurerm_network_interface.web-linux-vm-nic.id
  network_security_group_id = azurerm_network_security_group.web-linux-vm-nsg.id
}
