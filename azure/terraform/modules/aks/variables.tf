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

# Specific Vars
variable "service_principal_id" {
  description = "The ID of the service principal to use in the cluster."
}
variable "service_principal_secret" {
  description = "The secret of the service principal to use in the cluster."
}
variable "node_pools" {
  description = "An array containing the definition for node pools in the cluster. See documentation for more information."
  default     = []
  type        = list(object({
    name         = string
    size         = string
    count        = number
    min_count    = number
    max_count    = number
    auto_scaling = bool
    max_pods     = number
    node_taints  = list(string)
    disk_size    = number
  }))
}
variable "rbac_enabled" {
  description = "Whether to enable RBAC on Kubernetes or not."
  default     = true
  type        = bool
}