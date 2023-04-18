# subnet
resource "azurerm_subnet" "saas-app-subnet" {
  name = "${azurerm_virtual_network.saas-vnet.name}-${var.app_subnet_name}"
  resource_group_name = azurerm_resource_group.saas-rg.name
  virtual_network_name = azurerm_virtual_network.saas-vnet.name
  address_prefixes = var.app_subnet_cidr
}
# nsg
resource "azurerm_network_security_group" "saas-app-subnet-nsg" {
  name                = "${azurerm_subnet.saas-app-subnet.name}-nsg"
  location            = azurerm_resource_group.saas-rg.location
  resource_group_name = azurerm_resource_group.saas-rg.name
  tags = local.common_tags
}

# nsg rules
resource "azurerm_network_security_rule" "saas-app-subnet-nsg-rule-inbound" {
  for_each = {
    "100" : "80", # If the key starts with a number, you must use the colon syntax ":" instead of "="
    "110" : "443",
    "120" : "8080",
    "130" : "22"
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
  network_security_group_name = azurerm_network_security_group.saas-app-subnet-nsg.name
}

#nsg association
resource "azurerm_subnet_network_security_group_association" "saas-app-subnet-nsg-association" {
  depends_on = [
    azurerm_network_security_rule.saas-app-subnet-nsg-rule-inbound
  ]
  subnet_id                 = azurerm_subnet.saas-app-subnet.id
  network_security_group_id = azurerm_network_security_group.saas-app-subnet-nsg.id
}