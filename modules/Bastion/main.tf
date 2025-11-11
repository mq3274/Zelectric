
resource "azurerm_subnet" "baston-block" {
  for_each             = var.bastion_list
  name                 = "AzureBastionSubnet"
  resource_group_name  = each.value.resource_group_name
  virtual_network_name = each.value.virtual_network_name
  address_prefixes     = each.value.address_prefixes
}

resource "azurerm_public_ip" "pip-block" {
  for_each            = var.bastion_list
  name                = each.value.baston_pip
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

# resource "azurerm_bastion_host" "host" {
#   for_each            = var.bastion_list
#   name                = "bastion"
#   location            = each.value.location
#   resource_group_name = each.value.resource_group_name

#   ip_configuration {
#     name                 = "configuration"
#     subnet_id            = azurerm_subnet.baston-block[each.key].id
#     public_ip_address_id = azurerm_public_ip.pip-block[each.key].id
#   }
# }
