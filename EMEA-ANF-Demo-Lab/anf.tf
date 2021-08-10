# Create Azure NetApp Files Account 1
resource "azurerm_netapp_account" "anf_acc_1" {
  name                = "${var.prefix}-${var.geo}-${var.region_1}"
  resource_group_name = azurerm_resource_group.rg_1.name
  location            = var.region_1

  active_directory {
    username            = data.azurerm_key_vault_secret.join.name
    password            = data.azurerm_key_vault_secret.join.value
    smb_server_name     = var.prefix
    dns_servers         = [var.dns_server_1, 
                            var.dns_server_2, 
                            var.dns_server_3, 
                            var.dns_server_4
                        ]
    domain              = var.domain
    organizational_unit = var.ou
  }

  tags = {
    Environment = var.tag_environment
    CreatedBy   = var.tag_createdby
    CreatedWith = var.tag_createdwith
    Project     = var.tag_project
  }

}

# Create Azure NetApp Files Account 2
resource "azurerm_netapp_account" "anf_acc_2" {
  name                = "${var.prefix}-${var.geo}-${var.region_2}"
  resource_group_name = azurerm_resource_group.rg_2.name
  location            = var.region_2

  active_directory {
    username            = data.azurerm_key_vault_secret.join.name
    password            = data.azurerm_key_vault_secret.join.value
    smb_server_name     = var.prefix
    dns_servers         = [var.dns_server_1, 
                            var.dns_server_2, 
                            var.dns_server_3, 
                            var.dns_server_4
                        ]
    domain              = var.domain
    organizational_unit = var.ou
  }

  tags = {
    Environment = var.tag_environment
    CreatedBy   = var.tag_createdby
    CreatedWith = var.tag_createdwith
    Project     = var.tag_project
  }

}

# Create Azure NetApp Files Capacity Pool 1
resource "azurerm_netapp_pool" "anf_cap_1" {
  name                = "cap-${var.prefix}-${var.geo}-${var.region_1}"
  account_name        = azurerm_netapp_account.anf_acc_1.name
  location            = var.region_1
  resource_group_name = azurerm_resource_group.rg_1.name
  service_level       = var.cap_pool_tier
  size_in_tb          = var.cap_pool_size

  tags = {
    Environment = var.tag_environment
    CreatedBy   = var.tag_createdby
    CreatedWith = var.tag_createdwith
    Project     = var.tag_project
  }
}

# Create Azure NetApp Files Capacity Pool 2
resource "azurerm_netapp_pool" "anf_cap_2" {
  name                = "cap-${var.prefix}-${var.geo}-${var.region_2}"
  account_name        = azurerm_netapp_account.anf_acc_2.name
  location            = var.region_2
  resource_group_name = azurerm_resource_group.rg_2.name
  service_level       = var.cap_pool_tier
  size_in_tb          = var.cap_pool_size

  tags = {
    Environment = var.tag_environment
    CreatedBy   = var.tag_createdby
    CreatedWith = var.tag_createdwith
    Project     = var.tag_project
  }
}