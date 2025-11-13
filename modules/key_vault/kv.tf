data "azurerm_client_config" "current" {}

# One RG for all vaults (change if you want per-vault RGs)
resource "azurerm_resource_group" "rg" {
  name     = var.rg_name
  location = var.location
}

# Create many Key Vaults with for_each
resource "azurerm_key_vault" "kv" {
  for_each            = var.key_vaults
  name                = each.value.name           # must be globally unique
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  tenant_id                 = data.azurerm_client_config.current.tenant_id
  sku_name                  = each.value.sku_name                # "standard" or "premium"
  enable_rbac_authorization = true                               # prefer RBAC (modern)
  soft_delete_retention_days = coalesce(try(each.value.soft_delete_retention_days, null), 30)
  purge_protection_enabled   = lookup(each.value, "purge_protection_enabled", true)
  public_network_access_enabled = lookup(each.value, "public_network_access_enabled", true)

#   dynamic "network_acls" {
#     for_each = try([each.value.network_acls], [])
#     content {
#       bypass         = lookup(network_acls.value, "bypass", "AzureServices")
#       default_action = lookup(network_acls.value, "default_action", "Deny")
#       ip_rules       = lookup(network_acls.value, "ip_rules", [])
#     }
#   }

  tags = lookup(each.value, "tags", {})
}

# Optional: RBAC assignments to principals (users, SPNs, managed identities)
# kv_key must match a key in var.key_vaults
resource "azurerm_role_assignment" "kv_rbac" {
  for_each = {
    for ra in var.rbac_assignments :
    "${ra.kv_key}-${ra.principal_id}-${ra.role_definition_name}" => ra
  }

  scope                = azurerm_key_vault.kv[each.value.kv_key].id
  role_definition_name = each.value.role_definition_name      # e.g. "Key Vault Secrets Officer"
  principal_id         = each.value.principal_id              # objectId (GUID)
}

# Optional: create secrets across vaults
resource "azurerm_key_vault_secret" "secrets" {
  for_each    = var.secrets
  name        = each.key
  value       = each.value.value
  key_vault_id = azurerm_key_vault.kv[each.value.kv_key].id
  content_type = lookup(each.value, "content_type", null)
}

output "key_vault_ids" {
  value = { for k, v in azurerm_key_vault.kv : k => v.id }
}
