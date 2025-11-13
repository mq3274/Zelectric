# variable "key_vaults" {}
variable "rg_name"   { type = string }
variable "location"  { type = string }

variable "key_vaults" {
  description = "Map of Key Vault definitions keyed by a short name."
  type = map(object({
    name                        = string        # globally unique
    sku_name                    = string        # standard | premium
    soft_delete_retention_days  = optional(number, 30) # 7–90
    purge_protection_enabled    = optional(bool, true)
    public_network_access_enabled = optional(bool, true)
    network_acls = optional(object({
      bypass         = optional(string, "AzureServices") # AzureServices | None
      default_action = optional(string, "Deny")          # Allow | Deny
      ip_rules       = optional(list(string), [])
    }))
    tags = optional(map(string), {})
  }))
}

variable "rbac_assignments" {
  description = "List of RBAC grants to apply to vaults."
  type = list(object({
    kv_key               = string                 # key in var.key_vaults
    role_definition_name = string                 # e.g. Key Vault Secrets Officer
    principal_id         = string                 # Object ID (GUID) of user/SP/MI
  }))
  default = []
}

variable "secrets" {
  description = "Secrets to create across vaults, keyed by secret name."
  type = map(object({
    kv_key       = string  # key in var.key_vaults
    value        = string
    content_type = optional(string)
  }))
  default = {}
}

