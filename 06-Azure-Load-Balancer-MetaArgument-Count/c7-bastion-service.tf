# resource "azurerm_subnet" "bastion_service_subnet" {
#   name                 = var.bastion_service_subnet_name
#   resource_group_name  = azurerm_resource_group.saas-rg.name
#   virtual_network_name = azurerm_virtual_network.saas-vnet.name
#   address_prefixes     = var.bastion_service_subnet_cidr_address
# }

# resource "azurerm_public_ip" "bastion_service_public_ip" {
#   name = "${local.resource_name_prefix}-bastion-service-publicip"
#   location            = azurerm_resource_group.saas-rg.location
#   resource_group_name = azurerm_resource_group.saas-rg.name
#   allocation_method   = "Static"
#   sku = "Standard"  
# }

# resource "azurerm_bastion_host" "bastion_service_host" {
#   name = "${local.resource_name_prefix}-bastion-service"
#   location            = azurerm_resource_group.saas-rg.location
#   resource_group_name = azurerm_resource_group.saas-rg.name

#   ip_configuration {
#     name                 = "configuration"
#     subnet_id            = azurerm_subnet.bastion_service_subnet.id
#     public_ip_address_id = azurerm_public_ip.bastion_service_public_ip.id
#   }  
# }