resource "azurerm_api_management" "apim" {
  name                = "apim${var.environment}${var.base_name}"
  location            = var.region
  resource_group_name = var.rg_name
  publisher_name      = var.publisher_name
  publisher_email     = var.publisher_email

  sku_name = "${var.sku_name}_${var.node_count}"
 
  certificate {
    encoded_certificate = var.base64_encoded_certificate
    certificate_password = var.certificate_password
    store_name = var.store_name
  }
  
  policy {
    xml_content = <<XML
    <policies>
      <inbound />
      <backend />
      <outbound />
      <on-error />
    </policies>
XML
  }

  tags = merge({
    environment = var.environment
    base        = var.base_name
  }, var.tags)
}