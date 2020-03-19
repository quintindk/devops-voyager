variable "service_principal_id" {}
variable "service_principal_secret" {}
# variable "base64_encoded_certificate" {}
# variable "certificate_password" {}

# This provider defaults to using the AZ CLI login. Check the configuration below for more information
# on how to use a Service Principal.
provider "azurerm" {
  version = "=1.44.0"
}

# Default to using a storage account to hold state. This will make it easier to work as a team.
terraform {
  backend "azurerm" {
    resource_group_name  = "rgterraformstate"
    storage_account_name = "devopsvoyagertfstate"
    container_name       = "tfstate"
    key                  = "dev.terraform.tfstate"
  }
}

locals {
  environment   = "dev"
  base_name     = "opsvoyager"
  region        = "southafricanorth"
}

# Resource Group
module "rg" {
  source        = "../modules/rg"
  region        = local.region
  environment   = local.environment
  base_name     = local.base_name
}

# AppInsights
module "appinsights" {
  source                      = "../modules/ai"
  environment                 = local.environment
  base_name                   = local.base_name
  rg_name                     = module.rg.name
  type                        = "web"
}

# API Management
module "apim" {
  source                      = "../modules/apim"
  environment                 = local.environment
  base_name                   = local.base_name
  rg_name                     = module.rg.name
  publisher_name              = "Quintin de Kok"
  publisher_email             = "quintindk@tenagentsolutions.co.za"
  sku_name                    = "Developer"
  node_count                  = 1

  # ca_certificates             = [{
  #   base64_encoded_certificate  = var.base64_encoded_certificate
  #   certificate_password        = var.certificate_password
  #   store_name                  = "CertificateAuthority"
  # }]
  
  instrumentation_key         = module.appinsights.instrumentation_key
}
