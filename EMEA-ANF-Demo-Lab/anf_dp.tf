# Create Dual Protocol ANF Volumes, one with Unix and the other with Ntfs style permissions.

resource "azurerm_netapp_volume" "anf_dp_ntfs_vol" {
  lifecycle {
    prevent_destroy = false
  }

  name                = "vol-dp-ntfs-${var.use}-${var.prefix}-${var.geo}-${var.region_1}"
  location            = var.region_1
  resource_group_name = azurerm_resource_group.rg_1.name
  account_name        = azurerm_netapp_account.anf_acc_1.name
  pool_name           = azurerm_netapp_pool.anf_cap_1.name
  volume_path         = "${var.region_1}-dp-ntfs"
  service_level       = "Standard"
  protocols           = ["CIFS","NFSv3"]
  security_style      = "Ntfs"
  subnet_id           = azurerm_subnet.vnet_1_snet_2.id
  storage_quota_in_gb = 100

  export_policy_rule {
    rule_index          = 1
    allowed_clients     = [var.address_vnet_1_snet_1]
    protocols_enabled   = ["NFSv3"]
    unix_read_write     = true
    root_access_enabled = true
  }
}

resource "azurerm_netapp_volume" "anf_dp_unix_vol" {
  lifecycle {
    prevent_destroy = false
  }

  name                = "vol-dp-unix-${var.use}-${var.prefix}-${var.geo}-${var.region_1}"
  location            = var.region_1
  resource_group_name = azurerm_resource_group.rg_1.name
  account_name        = azurerm_netapp_account.anf_acc_1.name
  pool_name           = azurerm_netapp_pool.anf_cap_1.name
  volume_path         = "${var.region_1}-dp-unix"
  service_level       = "Standard"
  protocols           = ["NFSv3","CIFS"]
  security_style      = "Unix"
  subnet_id           = azurerm_subnet.vnet_1_snet_2.id
  storage_quota_in_gb = 100

  export_policy_rule {
    rule_index          = 1
    allowed_clients     = [var.address_vnet_1_snet_1]
    protocols_enabled   = ["NFSv3"]
    unix_read_write     = true
    root_access_enabled = true
  }
}