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

variable "base64_encoded_certificate" {
  description = "Base64 encoded certificate"
  default = null
}

variable "certificate_password" {
  description = "Secure string password for certificate"
  default = null
}

variable "store_name" {
  description = "Certificate Store where this certificate should be stored. Possible values are CertificateAuthority and Root."
  default = "CertificateAuthority"
}