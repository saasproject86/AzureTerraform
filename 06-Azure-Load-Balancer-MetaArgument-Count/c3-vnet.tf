resource "azurerm_virtual_network" "saas-vnet" {
    name = "${local.resource_name_prefix}-${var.vnet_name}"
    address_space = var.vnet_cidr
    location = azurerm_resource_group.saas-rg.location
    resource_group_name = azurerm_resource_group.saas-rg.name
    tags = local.common_tags
}