# Global Vars
variable "region" {
  description = "The region to deploy the resources in."
  default     = "southafricanorth"
}
variable "environment" {
  description = "The environment that the resources are deployed for."
  default     = "dev"
}
variable "base_name" {
  description = "The base name to use for all resources."
  default     = ""
}
variable "tags" {
  description = "The tags to add to the deployed resources."
  default     = {}
}

# Resource Group
variable "rg_name" {
  description = "The name of the resource group to deploy in."
}

# APIM Vars
variable "publisher_name" {
  description = "Publisher name for the API management configuration"
  default = "Tangent Solutions"
}

variable "publisher_email" {
  description = "Publisher email for the API management configuration"
  default = "info@tangetnsolutions.co.za"
}

variable "sku_name" {
  description = "Name of the SKU i.e. Developer, Basic, Standard, Premium"
  default = "Developer"
}

variable "node_count" {
  description = "The amount of nodes to spin up"
  default = "1"
}

variable "ca_certificates" {
  description = "The ca_certificates to load into the API managment instance."
  
  type        = list(object({
    base64_encoded_certificate  = string
    certificate_password        = string
    store_name                  = string
  }))
  
  default     = []
}

variable "instrumentation_key" {
  description = "The instrumentation key from the application insights instance for logging."
  default = null
}