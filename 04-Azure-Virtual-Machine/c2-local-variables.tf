locals {
  owner = var.business_division
  environment = var.environment

  resource_name_prefix = "${var.business_division}-${var.environment}"
  location = var.resource_group_location

  common_tags = {
    owner = local.owner,
    environment = local.environment
  }
}
