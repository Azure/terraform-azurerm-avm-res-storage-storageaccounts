output "containers" {
  description = "Map of storage containers that are created."
  value = {
    for name, container in azapi_resource.containers :
    name => {
      id   = container.id
      name = container.name
      name = azurerm_storage_account.this.name
      # public_access = jsondecode(container.body).properties.publicAccess
      public_access = container.body.properties.publicAccess
      # metadata      = jsondecode(container.body).properties.metadata
      metadata = container.body.properties.metadata
    }
  }
}

output "fqdn" {
  description = "Fqdns for storage services."
  value       = { for svc in local.endpoints : svc => "${azurerm_storage_account.this.name}.${svc}.core.windows.net" }
}

output "name" {
  description = "The name of the storage account"
  value       = azurerm_storage_account.this.name
}

output "private_endpoints" {
  description = "A map of private endpoints. The map key is the supplied input to var.private_endpoints. The map value is the entire azurerm_private_endpoint resource."
  value       = azurerm_private_endpoint.this
}

output "queues" {
  description = "Map of storage queues that are created."
  value = {
    for name, queue in azapi_resource.queue :
    name => {
      id   = queue.id
      name = queue.name
      name = azurerm_storage_account.this.name
    }
  }
}

output "resource" {
  description = "This is the full resource output for the Storage Account resource."
  sensitive   = true
  value       = azurerm_storage_account.this
}

output "resource_id" {
  description = "The ID of the Storage Account."
  value       = azurerm_storage_account.this.id
}

output "shares" {
  description = "Map of storage storage shares that are created."
  value = {
    for name, share in azapi_resource.share : name => {
      id                   = share.id
      name                 = share.name
      storage_account_name = azurerm_storage_account.this.name
      #metadata             = share.metadata
    }
  }
}

output "tables" {
  description = "Map of storage tables that are created."
  value = {
    for name, table in azapi_resource.table : name => {
      id   = table.id
      name = table.name
      name = azurerm_storage_account.this.name
    }
  }
}
