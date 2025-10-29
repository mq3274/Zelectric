resource "azurerm_network_interface" "nic-block" {
  for_each            = var.nic-list
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.sub-block[each.key].id
    private_ip_address_allocation = "Dynamic"
  }
}
