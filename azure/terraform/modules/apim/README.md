API Management
=============

A module to create an APIM instance using the correct SKU and number of nodes.

## Variables

The following variables are available:

### region

- __description__: The region to deploy the resources in.
- __default__: "southafricanorth"

### environment

- __description__: The environment that the resources are deployed for.
- __default__: "dev"

### base_name

- __description__: The base name to use for all resources.
- __default__: ""

### rg_name

- __description__: The name of the resource group to deploy in.
- __default__: null

### tags

- __description__: Additional tags to add to the deployed resources.
- __default__: null

### publisher_name

- __description__: Publisher name for the API management configuration.
- __default__: "Tangent Solutions"

### publisher_email

- __description__: Publisher email for the API management configuration
- __default__: "info@tangetnsolutions.co.za"

### sku_name

- __description__: Name of the SKU i.e. Developer, Basic, Standard, Premium
- __default__: "Developer"

### node_count

- __description__: The amount of nodes to spin up.
- __default__: "1"

### ca_certificates

- __decription__: The `certifcate` section described below. This is for the CA loading at the start of the API management instance creation. This is important so that you can add CAs later.

#### structure

This variable makes use of the following structure. (Items marked with "*" are required)

```yaml
[{
    base64_encoded_certificate  = string
    certificate_password        = string
    store_name                  = string
}]
```

- base64_encoded_certificate: Base64 encoded certificate.
- certificate_password: Secure string password for certificate
- store_name: Certificate Store where this certificate should be stored. Possible values are CertificateAuthority and Root.

### instrumentation_key
  
- __description__ : The instrumentation key from the application insights instance for logging."
- __default__ : null

## Outputs

The module provides the following output:

- __public_ip__: The public IP addresses associated to the API management instance.
- __gateway_url__: The gateway URL for the front door instance.

## Naming

This module uses the standard naming convention by prefix the resource type
to the environment and base name.

The following config will generate the name __apimdevilikepie__:

```{c#}
region      = "southafricanorth"
environment = "dev"
base_name   = "ilikepie"
```
