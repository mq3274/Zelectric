
resource "azurerm_storage_account" "stg-block" {
  for_each = var.stg-list
  name                     = each.value.name
  resource_group_name      = each.value.resource_group_name
  location                 = each.value.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "c-block" {
  name                  = "chaman"
  storage_account_name = "rgstoraccountcheck"
  container_access_type = "private"
}