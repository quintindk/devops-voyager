# This provider defaults to using the AZ CLI login. Check the configuration below for more information
# on how to use a Service Principal.
provider "azurerm" {
  version = "=1.44.0"

  # Set the targeted subscription ID.
  subscription_id = "00000000-0000-0000-0000-000000000000"

  # Uncomment these lines if you are planning on using a pipeline to deploy the infrastructure.
  # Ensure that the client_secret is not defined in line as we do not want to check it into source control.
  #client_id       = "00000000-0000-0000-0000-000000000000"
  #client_secret   = var.client_secret
  #tenant_id       = "00000000-0000-0000-0000-000000000000"
}

# Default to using a storage account to hold state. This will make it easier to work as a team.
terraform {
  backend "azurerm" {
    resource_group_name  = "state-storage"
    storage_account_name = "tfstorage"
    container_name       = "tfstate"
    key                  = "dev.terraform.tfstate"
  }
}