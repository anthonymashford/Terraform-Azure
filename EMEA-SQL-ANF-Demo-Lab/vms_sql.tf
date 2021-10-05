# Create random string for VM SQL 1
resource "random_string" "vm_sql_rs_1" {
  length  = 5
  special = false
}

# Create Public IP for VM SQL 1
resource "azurerm_public_ip" "pip_vmsql_1" {
  name                = "pip-${var.vm1_sql_name}-${random_string.vm_sql_rs_1.result}"
  resource_group_name = azurerm_resource_group.rg_1.name
  location            = azurerm_resource_group.rg_1.location
  allocation_method   = var.pip_allocation
  sku                 = var.pip_sku

  tags = {
    Environment = var.tag_environment
    CreatedBy   = var.tag_createdby
    CreatedWith = var.tag_createdwith
    Project     = var.tag_project
  }
}

# Create NIC for VM SQL 1
resource "azurerm_network_interface" "nic_vmsql_1" {
  name                = "nic-${var.vm1_sql_name}-${random_string.vm_sql_rs_1.result}"
  location            = azurerm_resource_group.rg_1.location
  resource_group_name = azurerm_resource_group.rg_1.name


  ip_configuration {
    name                          = "ipconfig-${var.vm1_sql_name}-${random_string.vm_sql_rs_1.result}"
    subnet_id                     = azurerm_subnet.vnet_1_snet_1.id
    private_ip_address_allocation = var.nic_ip_allocation
    public_ip_address_id          = azurerm_public_ip.pip_vmsql_1.id
  }

  tags = {
    Environment = var.tag_environment
    CreatedBy   = var.tag_createdby
    CreatedWith = var.tag_createdwith
    Project     = var.tag_project
  }

}

# Create VM SQL 1
resource "azurerm_windows_virtual_machine" "vmsql_1" {
  name                = "vm-${var.vm1_sql_name}-${random_string.vm_sql_rs_1.result}"
  depends_on          = [azurerm_key_vault.keyvault]
  resource_group_name = azurerm_resource_group.rg_1.name
  location            = azurerm_resource_group.rg_1.location
  size                = var.vm1_sql_size
  admin_username      = azurerm_key_vault_secret.admin_secret.name
  admin_password      = azurerm_key_vault_secret.admin_secret.value
  network_interface_ids = [
    azurerm_network_interface.nic_vmsql_1.id,
  ]

  os_disk {
    caching              = var.disk_caching
    storage_account_type = var.storage_account_type
  }

  source_image_reference {
    publisher = var.vm1_sql_publisher
    offer     = var.vm1_sql_offer
    sku       = var.vm1_sql_sku
    version   = var.vm1_sql_version
  }

  tags = {
    Environment = var.tag_environment
    CreatedBy   = var.tag_createdby
    CreatedWith = var.tag_createdwith
    Project     = var.tag_project
  }
}

# Join Demo VM SQL 1 to Domain
# Please note that the domain settings are bespoke to your individual environment. Please adjust them to suit.
resource "azurerm_virtual_machine_extension" "domjoinsql1" {
  depends_on = [
    azurerm_virtual_network_peering.peer-1-to-uks,
    azurerm_virtual_network_peering.peer-uks-to-1,
    azurerm_virtual_network_peering.peer-1-to-ukw,
    azurerm_virtual_network_peering.peer-ukw-to-1,
    azurerm_virtual_network_peering.peer-1-to-neu,
    azurerm_virtual_network_peering.peer-neu-to-1,
    azurerm_virtual_network_peering.peer-1-to-weu,
    azurerm_virtual_network_peering.peer-weu-to-1,
  ]
  name                 = "domjoin"
  virtual_machine_id   = azurerm_windows_virtual_machine.vmsql_1.id
  publisher            = "Microsoft.Compute"
  type                 = "JsonADDomainExtension"
  type_handler_version = "1.3"
  settings             = <<SETTINGS
        {
            "Name": "anf.test",
            "OUPath": "OU=anf-demo,DC=anf,DC=test",
            "User": "anf.test\\join",
            "Restart": "true",
            "Options": "3"
        }
        SETTINGS
  protected_settings   = <<PROTECTED_SETTINGS
        {
            "Password": "${data.azurerm_key_vault_secret.join.value}"
        }
        PROTECTED_SETTINGS  
}