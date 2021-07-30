# Create Public IP for VM1
resource "azurerm_public_ip" "pip_vm1" {
  name                = "pip-${var.vm1_name}"
  resource_group_name = azurerm_resource_group.rg_a.name
  location            = azurerm_resource_group.rg_a.location
  allocation_method   = var.pip_allocation
  sku                 = var.pip_sku

  tags = {
    Environment = var.tag_environment
    CreatedBy   = var.tag_createdby
    CreatedWith = var.tag_createdwith
    Project     = var.tag_project
  }
}

# Create Public IP for VM2
resource "azurerm_public_ip" "pip_vm2" {
  name                = "pip-${var.vm2_name}"
  resource_group_name = azurerm_resource_group.rg_b.name
  location            = azurerm_resource_group.rg_b.location
  allocation_method   = var.pip_allocation
  sku                 = var.pip_sku

  tags = {
    Environment = var.tag_environment
    CreatedBy   = var.tag_createdby
    CreatedWith = var.tag_createdwith
    Project     = var.tag_project
  }
}

# Create NIC for VM1
resource "azurerm_network_interface" "nic_vm1" {
  name                = "nic-${var.vm1_name}"
  location            = azurerm_resource_group.rg_a.location
  resource_group_name = azurerm_resource_group.rg_a.name


  ip_configuration {
    name                          = "ipconfig-${var.vm1_name}"
    subnet_id                     = azurerm_subnet.vnet_a_snet_a.id
    private_ip_address_allocation = var.nic_ip_allocation
    private_ip_address            = var.vm1_ip_address
    public_ip_address_id          = azurerm_public_ip.pip_vm1.id
  }

  tags = {
    Environment = var.tag_environment
    CreatedBy   = var.tag_createdby
    CreatedWith = var.tag_createdwith
    Project     = var.tag_project
  }
}

# Create NIC for VM2
resource "azurerm_network_interface" "nic_vm2" {
  name                = "nic-${var.vm2_name}"
  location            = azurerm_resource_group.rg_b.location
  resource_group_name = azurerm_resource_group.rg_b.name


  ip_configuration {
    name                          = "ipconfig-${var.vm2_name}"
    subnet_id                     = azurerm_subnet.vnet_b_snet_a.id
    private_ip_address_allocation = var.nic_ip_allocation
    private_ip_address            = var.vm2_ip_address
    public_ip_address_id          = azurerm_public_ip.pip_vm2.id
  }

  tags = {
    Environment = var.tag_environment
    CreatedBy   = var.tag_createdby
    CreatedWith = var.tag_createdwith
    Project     = var.tag_project
  }
}

# Create random string for disk name
resource "random_string" "rs_vm1_disk" {
  length  = 16
  special = false
}

# Create additional disk for VM1
resource "azurerm_managed_disk" "mdisk_vm1" {
  name                 = "mdisk-${var.vm1_name}_${random_string.rs_vm1_disk.result}"
  location             = azurerm_resource_group.rg_a.location
  resource_group_name  = azurerm_resource_group.rg_a.name
  storage_account_type = var.storage_account_type
  create_option        = var.create_option
  disk_size_gb         = var.disk_size_gb

  tags = {
    Environment = var.tag_environment
    CreatedBy   = var.tag_createdby
    CreatedWith = var.tag_createdwith
    Project     = var.tag_project
  }
}

# Create random string for disk name
resource "random_string" "rs_vm2_disk" {
  length  = 16
  special = false
}

# Create additional disk for VM2
resource "azurerm_managed_disk" "mdisk_vm2" {
  name                 = "mdisk-${var.vm2_name}_${random_string.rs_vm2_disk.result}"
  location             = azurerm_resource_group.rg_b.location
  resource_group_name  = azurerm_resource_group.rg_b.name
  storage_account_type = var.storage_account_type
  create_option        = var.create_option
  disk_size_gb         = var.disk_size_gb

  tags = {
    Environment = var.tag_environment
    CreatedBy   = var.tag_createdby
    CreatedWith = var.tag_createdwith
    Project     = var.tag_project
  }
}

# Create random string for disk name
resource "random_string" "rs_vm3_disk" {
  length  = 16
  special = false
}

# Create VM 1
resource "azurerm_windows_virtual_machine" "vm1" {
  name                = "vm-${var.vm1_name}"
  depends_on          = [azurerm_key_vault.keyvault]
  resource_group_name = azurerm_resource_group.rg_a.name
  location            = azurerm_resource_group.rg_a.location
  size                = var.vm1_size
  admin_username      = azurerm_key_vault_secret.admin_secret.name
  admin_password      = azurerm_key_vault_secret.admin_secret.value
  network_interface_ids = [
    azurerm_network_interface.nic_vm1.id,
  ]

  os_disk {
    caching              = var.disk_caching
    storage_account_type = var.storage_account_type
  }

  source_image_reference {
    publisher = var.vm1_publisher
    offer     = var.vm1_offer
    sku       = var.vm1_sku
    version   = var.vm1_version
  }

  tags = {
    Environment = var.tag_environment
    CreatedBy   = var.tag_createdby
    CreatedWith = var.tag_createdwith
    Project     = var.tag_project
  }
}

# Create VM 2
resource "azurerm_windows_virtual_machine" "vm2" {
  name                = "vm-${var.vm2_name}"
  depends_on          = [azurerm_key_vault.keyvault]
  resource_group_name = azurerm_resource_group.rg_b.name
  location            = azurerm_resource_group.rg_b.location
  size                = var.vm2_size
  admin_username      = azurerm_key_vault_secret.admin_secret.name
  admin_password      = azurerm_key_vault_secret.admin_secret.value
  network_interface_ids = [
    azurerm_network_interface.nic_vm2.id,
  ]

  os_disk {
    caching              = var.disk_caching
    storage_account_type = var.storage_account_type
  }

  source_image_reference {
    publisher = var.vm2_publisher
    offer     = var.vm2_offer
    sku       = var.vm2_sku
    version   = var.vm2_version
  }

  tags = {
    Environment = var.tag_environment
    CreatedBy   = var.tag_createdby
    CreatedWith = var.tag_createdwith
    Project     = var.tag_project
  }
}

# Attach disk to VM1
resource "azurerm_virtual_machine_data_disk_attachment" "mdisk_vm1" {
  managed_disk_id    = azurerm_managed_disk.mdisk_vm1.id
  depends_on         = [azurerm_windows_virtual_machine.vm1]
  virtual_machine_id = azurerm_windows_virtual_machine.vm1.id
  lun                = "10"
  caching            = "None"
}

# Attach disk to VM2
resource "azurerm_virtual_machine_data_disk_attachment" "mdisk_vm2" {
  managed_disk_id    = azurerm_managed_disk.mdisk_vm2.id
  depends_on         = [azurerm_windows_virtual_machine.vm2]
  virtual_machine_id = azurerm_windows_virtual_machine.vm2.id
  lun                = "10"
  caching            = "None"
}

resource "azurerm_virtual_machine_extension" "vm1_ext" {
  name                 = "vm1-setup"
  virtual_machine_id   = azurerm_windows_virtual_machine.vm1.id
  depends_on           = [azurerm_virtual_machine_data_disk_attachment.mdisk_vm1]
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.9"

  protected_settings = <<PROTECTED_SETTINGS
    {
      "commandToExecute": "powershell.exe -Command \"./vm1_config.ps1; exit 0;\""
    }
  PROTECTED_SETTINGS

  settings = <<SETTINGS
    {
        "fileUris": [
          "https://raw.githubusercontent.com/anthonymashford/Terraform-Azure/main/Deploy-Demo-Lab-VM/scripts/vm1/vm1_config.ps1"
        ]
    }
  SETTINGS
}