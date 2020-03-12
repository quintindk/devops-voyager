resource "azurerm_kubernetes_cluster" "aks" {
  name                = "aks${var.environment}${var.base_name}"
  location            = var.region
  resource_group_name = var.rg_name
  dns_prefix          = "aks${var.environment}${var.base_name}"

  service_principal {
    client_id         = var.service_principal_id
    client_secret     = var.service_principal_secret
  }

  # NOTE: This will be deprecated in V2 of terraform. Change to default_node_pool.
  # NOTE: This will be deprecated in V2 of terraform. Change to default_node_pool.
  dynamic "agent_pool_profile" {
    for_each = var.node_pools
    content {
      name                = agent_pool_profile.value.name
      vm_size             = agent_pool_profile.value.size
      count               = agent_pool_profile.value.count
      min_count           = agent_pool_profile.value.min_count
      max_count           = agent_pool_profile.value.max_count
      enable_auto_scaling = agent_pool_profile.value.auto_scaling
      max_pods            = agent_pool_profile.value.max_pods
      node_taints         = agent_pool_profile.value.node_taints
      os_disk_size_gb     = agent_pool_profile.value.disk_size
      type                = agent_pool_profile.value.auto_scaling == true ? "VirtualMachineScaleSets" : "AvailabilitySet"
    }
  }

  role_based_access_control {
    enabled = var.rbac_enabled
  }

  network_profile {
    network_plugin = "kubenet"
  }

  tags = merge({
    environment = var.environment
    base        = var.base_name
  }, var.tags)
}
