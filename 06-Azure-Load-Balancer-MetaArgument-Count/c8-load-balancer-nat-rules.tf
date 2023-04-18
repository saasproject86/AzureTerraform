resource "azurerm_lb_nat_rule" "lb_web_inbound_nat_rules" {
  depends_on = [
    azurerm_linux_virtual_machine.web-linux-vm
  ]
  resource_group_name            = azurerm_resource_group.saas-rg.name
  loadbalancer_id                = azurerm_lb.lb_web.id
  name                           = "SSHAccess"
  protocol                       = "Tcp"
  frontend_port                  = 1033
  backend_port                   = 22
  frontend_ip_configuration_name = azurerm_lb.lb_web.frontend_ip_configuration[0].name
}

resource "azurerm_network_interface_nat_rule_association" "lb_nat_nic_web_association" {
  network_interface_id  = azurerm_network_interface.web-linux-vm-nic.id
  ip_configuration_name = azurerm_network_interface.web-linux-vm-nic.ip_configuration[0].name
  nat_rule_id           = azurerm_lb_nat_rule.lb_web_inbound_nat_rules.id
}