module "rg-block" {
  source  = "../../modules/Resource_grp"
  rg_list = var.rg_mod
}

# module "key-block" {
#   depends_on = [module.rg-block]
#   source     = "../../modules/key_vault"
#   key_vaults = var.key-mod
# }

module "vnet-block" {
  depends_on = [module.rg-block]
  source     = "../../modules/Vnet"
  vnet_list  = var.vnet_mod
}

module "subnet-block" {
  depends_on = [module.vnet-block]
  source     = "../../modules/subnet"
  sub_list   = var.sub_mod
}

module "bastion-block" {
  depends_on   = [module.subnet-block]
  source       = "../../modules/Bastion"
  bastion_list = var.bastion_mod
}

module "vms-block" {
  depends_on = [module.subnet-block]
  source     = "../../modules/Virtual_machine"
  vms_list   = var.vms_mod
}
