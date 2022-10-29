resource "random_string" "rand" {
  length    = 5
  special   = false
  upper     = false
}

resource "azurerm_resource_group" "default" {
  name      = var.resource_group
  location  = var.location
}

resource "azurerm_storage_account" "storage_account" {
  name                        = "${var.storage_account}${random_string.rand.result}"
  resource_group_name         = azurerm_resource_group.default.name
  location                    = azurerm_resource_group.default.location
  account_tier                = "Standard"
  account_replication_type    = "LRS"
}

resource "azurerm_storage_container" "storage_container" {
    name                    = "terraform"
    storage_account_name    = azurerm_storage_account.storage_account.name
    container_access_type   = "blob"
}

# data "azurerm_storage_account_sas" "storage_sas" {
#     connection_string = azurerm_storage_account.storage_account.primary_connection_string

#     resource_types {
#         service   = false
#         container = false
#         object    = false
#     }

#     services {
#         blob    = true
#         queue   = false
#         table   = false
#         file    = false
#     }

#     start   = "2022-06-19T00:00:00Z"
#     expiry  = "2025-06-19T00:00:00Z"

#     permissions {
#         read    = true
#         write   = false
#         delete  = false
#         list    = false
#         add     = false
#         create  = false
#         update  = false
#         process = false
#     }
# }