# Create Azure NetApp Files Account 1
resource "azurerm_netapp_account" "anf_acc_1" {
  name                = "anf-${var.use}-${var.prefix}-${var.geo}-${var.region_1}"
  resource_group_name = azurerm_resource_group.rg_1.name
  location            = var.region_1

  # Acitve Directory configuration. 
  # This section has been commented out as an ANF account already exists in the demo subscription and region(s).
  # Uncomment this section if you need to add Active Directory configuration and amend the .tfvars file to suit.
/*
  active_directory {
    username            = data.azurerm_key_vault_secret.join.name
    password            = data.azurerm_key_vault_secret.join.value
    smb_server_name     = var.prefix
    dns_servers         = [var.dns_server_3]
    domain              = var.domain
    organizational_unit = var.ou
  }
*/
  tags = {
    Environment = var.tag_environment
    CreatedBy   = var.tag_createdby
    CreatedWith = var.tag_createdwith
    Project     = var.tag_project
  }

}

# Create Azure NetApp Files Account 2
resource "azurerm_netapp_account" "anf_acc_2" {
  name                = "anf-${var.use}-${var.prefix}-${var.geo}-${var.region_2}"
  resource_group_name = azurerm_resource_group.rg_2.name
  location            = var.region_2

  # Acitve Directory configuration. 
  # This section has been commented out as an ANF account already exists in the demo subscription region.
  # Uncomment this section if you need to add Active Directory configuration and amend the .tfvars file.
  /*  
  active_directory {
    username            = data.azurerm_key_vault_secret.join.name
    password            = data.azurerm_key_vault_secret.join.value
    smb_server_name     = var.prefix
    dns_servers         = [var.dns_server_4]
    domain              = var.domain
    organizational_unit = var.ou
  }
*/
  tags = {
    Environment = var.tag_environment
    CreatedBy   = var.tag_createdby
    CreatedWith = var.tag_createdwith
    Project     = var.tag_project
  }

}

# Create Azure NetApp Files Capacity Pool 1
resource "azurerm_netapp_pool" "anf_cap_1" {
  name                = "cap-${var.use}-${var.prefix}-${var.geo}-${var.region_1}"
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
  name                = "cap-${var.use}-${var.prefix}-${var.geo}-${var.region_2}"
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

# Create Azure NetApp Files NFS Volume 1
resource "azurerm_netapp_volume" "anf_nfs_vol_1" {
  lifecycle {
    prevent_destroy = false
  }

  name                = "vol-nfs-${var.use}-${var.prefix}-${var.geo}-${var.region_1}"
  location            = var.region_1
  resource_group_name = azurerm_resource_group.rg_1.name
  account_name        = azurerm_netapp_account.anf_acc_1.name
  pool_name           = azurerm_netapp_pool.anf_cap_1.name
  volume_path         = "${var.vol_path_nfs}-${var.region_1}"
  service_level       = var.service_level_std
  subnet_id           = azurerm_subnet.vnet_1_snet_2.id
  protocols           = [var.protocol_nfs]
  storage_quota_in_gb = 1024

  export_policy_rule {
    rule_index          = 1
    allowed_clients     = [var.address_vnet_1_snet_1]
    protocols_enabled   = ["NFSv3"]
    unix_read_write     = true
    root_access_enabled = true
  }

  tags = {
    Environment = var.tag_environment
    CreatedBy   = var.tag_createdby
    CreatedWith = var.tag_createdwith
    Project     = var.tag_project
  }
}

# Create Azure NetApp Files NFS Volume 2
resource "azurerm_netapp_volume" "anf_nfs_vol_2" {
  lifecycle {
    prevent_destroy = false
  }

  name                = "vol-nfs-${var.use}-${var.prefix}-${var.geo}-${var.region_2}"
  location            = var.region_2
  resource_group_name = azurerm_resource_group.rg_2.name
  account_name        = azurerm_netapp_account.anf_acc_2.name
  pool_name           = azurerm_netapp_pool.anf_cap_2.name
  volume_path         = "${var.vol_path_nfs}-${var.region_2}"
  service_level       = var.service_level_std
  subnet_id           = azurerm_subnet.vnet_2_snet_2.id
  protocols           = [var.protocol_nfs]
  storage_quota_in_gb = 1024

  export_policy_rule {
    rule_index          = 1
    allowed_clients     = [var.address_vnet_2_snet_1]
    protocols_enabled   = ["NFSv3"]
    unix_read_write     = true
    root_access_enabled = true
  }

  tags = {
    Environment = var.tag_environment
    CreatedBy   = var.tag_createdby
    CreatedWith = var.tag_createdwith
    Project     = var.tag_project
  }

  data_protection_replication {
    endpoint_type             = "dst"
    remote_volume_location    = azurerm_resource_group.rg_1.location
    remote_volume_resource_id = azurerm_netapp_volume.anf_nfs_vol_1.id
    replication_frequency     = "10minutes"
  }

}

# Create Azure NetApp Files SMB Volume 1
resource "azurerm_netapp_volume" "anf_smb_vol_1" {
  lifecycle {
    prevent_destroy = false
  }

  name                = "vol-smb-${var.use}-${var.prefix}-${var.geo}-${var.region_1}"
  location            = var.region_1
  resource_group_name = azurerm_resource_group.rg_1.name
  account_name        = azurerm_netapp_account.anf_acc_1.name
  pool_name           = azurerm_netapp_pool.anf_cap_1.name
  volume_path         = "${var.vol_path_smb}-${var.region_1}"
  service_level       = var.service_level_std
  subnet_id           = azurerm_subnet.vnet_1_snet_2.id
  protocols           = [var.protocol_smb]
  storage_quota_in_gb = 1024

  tags = {
    Environment = var.tag_environment
    CreatedBy   = var.tag_createdby
    CreatedWith = var.tag_createdwith
    Project     = var.tag_project
  }
}

# Create Azure NetApp Files SMB Volume 2
resource "azurerm_netapp_volume" "anf_smb_vol_2" {
  lifecycle {
    prevent_destroy = false
  }

  name                = "vol-smb-${var.use}-${var.prefix}-${var.geo}-${var.region_2}"
  location            = var.region_2
  resource_group_name = azurerm_resource_group.rg_2.name
  account_name        = azurerm_netapp_account.anf_acc_2.name
  pool_name           = azurerm_netapp_pool.anf_cap_2.name
  volume_path         = "${var.vol_path_smb}-${var.region_2}"
  service_level       = var.service_level_std
  subnet_id           = azurerm_subnet.vnet_2_snet_2.id
  protocols           = [var.protocol_smb]
  storage_quota_in_gb = 1024

  tags = {
    Environment = var.tag_environment
    CreatedBy   = var.tag_createdby
    CreatedWith = var.tag_createdwith
    Project     = var.tag_project
  }
  
  data_protection_replication {
    endpoint_type             = "dst"
    remote_volume_location    = azurerm_resource_group.rg_1.location
    remote_volume_resource_id = azurerm_netapp_volume.anf_smb_vol_1.id
    replication_frequency     = "10minutes"
  }

}