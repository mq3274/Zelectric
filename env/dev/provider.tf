terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.0.1"
    }
  }
  #  backend "azurerm" {
  #     resource_group_name = "rg-resources"
  #     storage_account_name = "rgstoraccountcheck"                            
  #     container_name       = "vhds"                               
  #     key                  = "prod.terraform.tfstate"                
  #   }

}
provider "azurerm" {
  features {}
  subscription_id = "b32c109d-d9ae-45aa-be9c-e990770dd571"
  tenant_id       = "c81ca467-e4da-4e3d-aa3f-6bff2ca4d433"
}