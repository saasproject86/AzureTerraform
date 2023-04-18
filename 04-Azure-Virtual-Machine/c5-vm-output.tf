output "web_linux_vm_public_ip" {
  description = "Web linux vm public ip"
  value = azurerm_public_ip.web-vm-public-ip.ip_address
}

output "web_linux_vm_network_interface_id" {
  description = "Web linux vm network interface card id"
  value = azurerm_network_interface.web-linux-vm-nic.id
} 

output "web_linux_vm_private_ip" {
  description = "Web linux vm private ip addresses"
  value = [azurerm_network_interface.web-linux-vm-nic.private_ip_addresses]
} 

output "web_linux_vm_id" {
  description = "Web linux vm id"
  value = azurerm_linux_virtual_machine.web-linux-vm.id
} 

