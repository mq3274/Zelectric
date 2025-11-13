rg_name  = "rg-sec-shared-weu"
location = "westeurope"

key_vaults = {
  prod = {
    name       = "kv-prod-1234"       # must be unique globally
    sku_name   = "standard"
    network_acls = {
      default_action = "Deny"
      ip_rules       = ["203.0.113.10/32", "198.51.100.0/24"]
    }
    tags = { env = "prod", owner = "secops" }
  }

  dev = {
    name       = "kv-dev-1234"
    sku_name   = "standard"
    public_network_access_enabled = true
    tags = { env = "dev" }
  }
}

# Example: grant Secrets Officer on both vaults to a user/sp/service principal
rbac_assignments = [
  {
    kv_key               = "prod"
    role_definition_name = "Key Vault Secrets Officer"
    principal_id         = "00000000-0000-0000-0000-000000000001"
  },
  {
    kv_key               = "dev"
    role_definition_name = "Key Vault Secrets User"
    principal_id         = "00000000-0000-0000-0000-000000000002"
  }
]

secrets = {
  "db-password" = { kv_key = "prod", value = "S3cr3t!" }
  "api-key"     = { kv_key = "dev",  value = "abcd-efgh-1234" }
}
