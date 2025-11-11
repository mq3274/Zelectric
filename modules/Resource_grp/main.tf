
resource "azurerm_resource_group" "rg-block" {
  for_each = var.rg_list
  name     = each.value.resource_group_name
  location = each.value.location
}
