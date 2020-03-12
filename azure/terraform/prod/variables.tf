variable "client_secret" {
  description = "The service principal secret. Don't hard code this."
  default     = ""
}

variable "region" {
  description = "The region to deploy the resources in."
  default     = "southafricanorth"
}