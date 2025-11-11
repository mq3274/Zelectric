rg_mod = {
  rg1 = {
    location            = "centralindia"
    resource_group_name = "raju"
  }
}

# key-mod = {
#   key1 = {
#     location            = "centralindia"
#     resource_group_name = "raju"
#     kv_name             = "buddy-key"
#     admin_user          = "adminuser"
#     admin_password      = "Password@123"
#   }
# }

vnet_mod = {
  vnet1 = {
    name                = "v_network"
    address_space       = ["10.0.0.0/16"]
    location            = "centralindia"
    resource_group_name = "raju"
  }
}

sub_mod = {
  private = {
    name                 = "private"
    resource_group_name  = "raju"
    virtual_network_name = "v_network"
    address_prefixes     = ["10.0.1.0/24"]
  }

  public = {
    name                 = "public"
    resource_group_name  = "raju"
    virtual_network_name = "v_network"
    address_prefixes     = ["10.0.2.0/24"]
  }
}


bastion_mod = {
  bastion1 = {
    resource_group_name  = "raju"
    virtual_network_name = "v_network"
    baston_pip           = "baston_pip"
    location             = "centralindia"
    address_prefixes     = ["10.0.3.0/24"]
  }
}

vms_mod = {
  vm1 = {
    subnet_name          = "private"
    virtual_network_name = "v_network"
    resource_group_name  = "raju"
    location             = "centralindia"
    nic_name             = "vm_nic"
    vm_name              = "linuxmachine"
    size                 = "Standard_F2"

  }
}
