locals {
bastionvm_custom_data = <<CUSTOM_DATA
#!/bin/sh
sudo apt update -y
CUSTOM_DATA
}

# bastion vm 
resource "azurerm_linux_virtual_machine" "bastion-linux-vm" {
  name                  = "${local.resource_name_prefix}-bastion-linux-vm"
  location              = azurerm_resource_group.saas-rg.location
  resource_group_name   = azurerm_resource_group.saas-rg.name
  network_interface_ids = [azurerm_network_interface.bastion-linux-vm-nic.id]
  size               = var.linux_vm_size
  admin_username      = "azureuser"

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-lts"
    version   = "latest"
  }

  # source_image_reference {
  #   publisher = "RedHat"
  #   offer = "RHEL"
  #   sku = "8-gen2"
  #   version = "latest"
  # }

  os_disk {
    name    = "bastion-vm-osdisk1"
    caching = "ReadWrite"
    # create_option     = "FromImage"
    storage_account_type = "Standard_LRS"
  }

  admin_ssh_key {
    username   = "azureuser"
    public_key = file("${path.module}/ssh-keys/id_rsa.pub")
  }

  tags = local.common_tags

  custom_data = base64encode(local.bastionvm_custom_data)
}

resource "null_resource" "null_resource_copy_ssh_key_to_bastion" {
  # depends on
  depends_on = [
    azurerm_linux_virtual_machine.bastion-linux-vm
  ]

  # connect
  connection {
    type = "ssh"
    user = azurerm_linux_virtual_machine.bastion-linux-vm.admin_username
    host = azurerm_linux_virtual_machine.bastion-linux-vm.public_ip_address
    private_key = file("${path.module}/ssh-keys/id_rsa")
  }
  
  # file provisioner, copy private key file to bastion server
  
  provisioner "file" {
    source      = "ssh-keys/id_rsa"
    destination = "/tmp/id_rsa"
  }

  # provider remote-exec
  provisioner "remote-exec" {
    # change mode
    inline = [
      "sudo chmod 400 /tmp/id_rsa"
    ]
  }
  
}