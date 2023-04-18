resource "azurerm_resource_group" "saas-rg" {
  #name = "${local.resource_name_prefix}-${var.resource_group_name}"
  name = "${local.resource_name_prefix}-${var.resource_group_name}-${random_string.random_str.id}"
  location = var.resource_group_location
  tags = local.common_tags
}
