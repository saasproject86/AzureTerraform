resource "azurerm_public_ip" "lb_web_public_ip" {
  name                = "${local.resource_name_prefix}-lb-web-public-ip"
  location            = azurerm_resource_group.saas-rg.location
  resource_group_name = azurerm_resource_group.saas-rg.name
  allocation_method   = "Static"
  sku = "Standard"
  tags = local.common_tags
}

resource "azurerm_lb" "lb_web" {
  name                = "${local.resource_name_prefix}-lb-web"
  location            = azurerm_resource_group.saas-rg.location
  resource_group_name = azurerm_resource_group.saas-rg.name
  sku = "Standard"
  frontend_ip_configuration {
    name                 = "lb-web-public-ip-1"
    public_ip_address_id = azurerm_public_ip.lb_web_public_ip.id
  }
}

# backend
resource "azurerm_lb_backend_address_pool" "lb_web_backend_pool" {
  loadbalancer_id = azurerm_lb.lb_web.id
  name            = "WebBackendAddressPool"
}

# probe
resource "azurerm_lb_probe" "lb_web_probe" {
  name            = "tcp-running-probe"
  loadbalancer_id = azurerm_lb.lb_web.id
  port            = 80
  protocol = "Tcp"
}
# rules
resource "azurerm_lb_rule" "lb_web_rules" {
  name                           = "LBWebApp1Rule"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = azurerm_lb.lb_web.frontend_ip_configuration[0].name
  backend_address_pool_ids = [azurerm_lb_backend_address_pool.lb_web_backend_pool.id]
  loadbalancer_id                = azurerm_lb.lb_web.id
  probe_id = azurerm_lb_probe.lb_web_probe.id
}
# association
resource "azurerm_network_interface_backend_address_pool_association" "lb_web_nic_associate" {
  network_interface_id    = azurerm_network_interface.web-linux-vm-nic.id
  ip_configuration_name   = azurerm_network_interface.web-linux-vm-nic.ip_configuration[0].name
  backend_address_pool_id = azurerm_lb_backend_address_pool.lb_web_backend_pool.id
}
