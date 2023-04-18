output "bastion_linux_vm_public_ip" {
  description = "bastion linux vm public ip"
  value = azurerm_public_ip.bastion-vm-public-ip.ip_address
}

output "bastion_linux_vm_network_interface_id" {
  description = "bastion linux vm network interface card id"
  value = azurerm_network_interface.bastion-linux-vm-nic.id
} 

output "bastion_linux_vm_private_ip" {
  description = "bastion linux vm private ip addresses"
  value = [azurerm_network_interface.bastion-linux-vm-nic.private_ip_addresses]
} 

output "bastion_linux_vm_id" {
  description = "bastion linux vm id"
  value = azurerm_linux_virtual_machine.bastion-linux-vm.id
} 
