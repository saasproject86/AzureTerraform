locals {
webvm_custom_data = <<CUSTOM_DATA
#!/bin/sh
#sudo apt update -y
sudo apt-get install -y apache2
sudo chmod -R 777 /var/www/html 
sudo echo "Welcome to SaasProject - WebVM App1 - VM Hostname: $(hostname)" > /var/www/html/index.html
sudo mkdir /var/www/html/app1
sudo echo "Welcome to SaasProject - WebVM App1 - VM Hostname: $(hostname)" > /var/www/html/app1/hostname.html
sudo echo "Welcome to SaasProject - WebVM App1 - App Status Page" > /var/www/html/app1/status.html
sudo echo '<!DOCTYPE html> <html> <body style="background-color:rgb(250, 210, 210);"> <h1>Welcome to SaasProject - WebVM APP-1 </h1> <p>Terraform Demo</p> <p>Application Version: V1</p> </body></html>' | sudo tee /var/www/html/app1/index.html
sudo curl -H "Metadata:true" --noproxy "*" "http://169.254.169.254/metadata/instance?api-version=2020-09-01" -o /var/www/html/app1/metadata.html
CUSTOM_DATA
}

# vm 
resource "azurerm_linux_virtual_machine" "web-linux-vm" {
  name                  = "${local.resource_name_prefix}-web-linux-vm"
  location              = azurerm_resource_group.saas-rg.location
  resource_group_name   = azurerm_resource_group.saas-rg.name
  network_interface_ids = [azurerm_network_interface.web-linux-vm-nic.id]
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
    name    = "web-vm-osdisk1"
    caching = "ReadWrite"
    # create_option     = "FromImage"
    storage_account_type = "Standard_LRS"
  }

  admin_ssh_key {
    username   = "azureuser"
    public_key = file("${path.module}/ssh-keys/id_rsa.pub")
  }

  tags = local.common_tags

  custom_data = base64encode(local.webvm_custom_data)
}
