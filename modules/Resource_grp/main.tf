
resource "azurerm_resource_group" "r-block" {
  for_each = var.rg-list
  name     = each.key
  location = each.value
}
