resource "azurerm_application_insights" "appinsights" {
  name                = "ai${var.environment}${var.base_name}"
  location            = var.region
  resource_group_name = var.rg_name
  application_type    = var.type
}
