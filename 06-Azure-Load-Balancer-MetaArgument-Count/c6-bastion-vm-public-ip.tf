# vm pulic addresss 
resource "azurerm_public_ip" "bastion-vm-public-ip" {
  name                = "${local.resource_name_prefix}-bastion-linux-public-ip"
  resource_group_name = azurerm_resource_group.saas-rg.name
  location            = azurerm_resource_group.saas-rg.location
  allocation_method   = "Static"
  sku = "Standard"
  domain_name_label = "app1-vm-${random_string.random_str.id}"
  tags = local.common_tags
}
