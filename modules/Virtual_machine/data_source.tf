data "azurerm_subnet" "data-subnet" {
  for_each             = var.vms_list
  name                 = each.value.subnet_name
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.resource_group_name
}

data "azurerm_key_vault" "kv-block" {
  name                = "bebo-key"
  resource_group_name = "raju"
}

data "azurerm_key_vault_secret" "adminuser" {
  name         = "adminuser"
  key_vault_id = data.azurerm_key_vault.kv-block.id
}

data "azurerm_key_vault_secret" "password" {
  name         = "password"
  key_vault_id = data.azurerm_key_vault.kv-block.id
}
