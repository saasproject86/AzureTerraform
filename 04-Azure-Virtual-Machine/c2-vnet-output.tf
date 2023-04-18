output "vnet_name" {
  description = "Virtual network name"
  value = azurerm_virtual_network.saas-vnet.name
}

output "vnet_id" {
  description = "Virtual network ID"
  value = azurerm_virtual_network.saas-vnet.id
}

output "app_subnet_name" {
  description = "App subnet name"
  value = azurerm_subnet.saas-app-subnet.name
}

output "web_subnet_name" {
  description = "Web subnet name"
  value = azurerm_subnet.saas-web-subnet.name
}

output "db_subnet_name" {
  description = "DB subnet name"
  value = azurerm_subnet.saas-db-subnet.name
}

output "bastion_subnet_name" {
  description = "Bastion subnet name"
  value = azurerm_subnet.saas-bastion-subnet.name
}