output "public_ips" {
  value = azurerm_api_management.apim.public_ip_addresses[0]
}
output "gateway_url" {
  value = replace(azurerm_api_management.apim.gateway_url, "https://", "")
}