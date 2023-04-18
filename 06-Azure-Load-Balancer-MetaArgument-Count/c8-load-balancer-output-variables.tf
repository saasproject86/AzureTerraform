output "lb_name" {
    description = "Load balancer for web application name"
    value = azurerm_lb.lb_web.name
}

output "lb_web_public_ip_address" {
    description = "Load balancer public ip address"
    value = azurerm_public_ip.lb_web_public_ip.ip_address
}

output "lb_web_frontend_ip_configuration" {
    description = "LB Web frontend_ip_configuration Block"
    value = [azurerm_lb.lb_web.frontend_ip_configuration]
}