Application Insights
===========

A module to create an instance of Application Insights for monitoring.

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

### type

- __description__: Type of Application Insights to create. Valid values are ios, java, MobileCenter, Node.JS, other, phone, store and web for ASP.NET.
- __default__: web

## Outputs

The module provides the following output:

- __instrumentation_key__: The public IP addresses associated to the API management instance.
- __app_id__: The gateway URL for the front door instance.

## Naming

This module uses the standard naming convention by prefix the resource type
to the environment and base name.

The following config will generate the name __aidevilikepie__:

```{c#}
region      = "southafricanorth"
environment = "dev"
base_name   = "ilikepie"
```
