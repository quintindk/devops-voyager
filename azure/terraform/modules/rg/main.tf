# Create the resource group.
resource "azurerm_resource_group" "rg" {
  name     = "rg${var.environment}${var.base_name}"
  location = var.region

  tags = merge({
    environment = var.environment
    base        = var.base_name
  }, var.tags)
}