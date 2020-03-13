RG
==

Simple helper module to create resource groups with the correct naming
convention and tags.

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

### tags

- __description__: Additional tags to add to the deployed resources.
- __default__: null

## Usage

```
module "rg" {
  source = "../modules/rg"

  region      = "southafricanorth"
  environment = "dev"
  base_name   = "ilikepie"
}
```

## Outputs

The module provides the following output:

- __name__: The name of the resource group.
- __region__: The region the resource group was created in.

## Naming

This module uses the standard naming convention by prefix the resource type
to the environment and base name.

The following config will generate the name __rgdevilikepie__:

```
region      = "southafricanorth"
environment = "dev"
base_name   = "ilikepie"
```