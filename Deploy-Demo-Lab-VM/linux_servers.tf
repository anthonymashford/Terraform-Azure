# Create Public IP for VM3
resource "azurerm_public_ip" "pip_vm3" {
  name                = "pip-${var.vm3_name}"
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

# Create Public IP for VM4
resource "azurerm_public_ip" "pip_vm4" {
  name                = "pip-${var.vm4_name}"
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

# Create NIC for VM3
resource "azurerm_network_interface" "nic_vm3" {
  name                = "nic-${var.vm3_name}"
  location            = azurerm_resource_group.rg_a.location
  resource_group_name = azurerm_resource_group.rg_a.name

  ip_configuration {
    name                          = "ipconfig-${var.vm3_name}"
    subnet_id                     = azurerm_subnet.vnet_a_snet_a.id
    private_ip_address_allocation = var.nic_ip_allocation
    private_ip_address            = var.vm3_ip_address
    public_ip_address_id          = azurerm_public_ip.pip_vm3.id
  }

  tags = {
    Environment = var.tag_environment
    CreatedBy   = var.tag_createdby
    CreatedWith = var.tag_createdwith
    Project     = var.tag_project
  }
}

# Create NIC for VM4
resource "azurerm_network_interface" "nic_vm4" {
  name                = "nic-${var.vm4_name}"
  location            = azurerm_resource_group.rg_b.location
  resource_group_name = azurerm_resource_group.rg_b.name

  ip_configuration {
    name                          = "ipconfig-${var.vm4_name}"
    subnet_id                     = azurerm_subnet.vnet_b_snet_a.id
    private_ip_address_allocation = var.nic_ip_allocation
    private_ip_address            = var.vm4_ip_address
    public_ip_address_id          = azurerm_public_ip.pip_vm4.id
  }

  tags = {
    Environment = var.tag_environment
    CreatedBy   = var.tag_createdby
    CreatedWith = var.tag_createdwith
    Project     = var.tag_project
  }
}

# Create additional disk for VM3
resource "azurerm_managed_disk" "mdisk_vm3" {
  name                 = "mdisk-${var.vm3_name}_${random_string.rs_vm3_disk.result}"
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
resource "random_string" "rs_vm4_disk" {
  length  = 16
  special = false
}

# Create additional disk for VM4
resource "azurerm_managed_disk" "mdisk_vm4" {
  name                 = "mdisk-${var.vm4_name}_${random_string.rs_vm4_disk.result}"
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

# Create VM 3
resource "azurerm_linux_virtual_machine" "vm3" {
  name                            = "vm-${var.vm3_name}"
  depends_on                      = [azurerm_key_vault.keyvault]
  resource_group_name             = azurerm_resource_group.rg_a.name
  location                        = azurerm_resource_group.rg_a.location
  size                            = var.vm3_size
  admin_username                  = azurerm_key_vault_secret.admin_secret.name
  admin_password                  = azurerm_key_vault_secret.admin_secret.value
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.nic_vm3.id,
  ]

  os_disk {
    caching              = var.disk_caching
    storage_account_type = var.storage_account_type
  }

  source_image_reference {
    publisher = var.vm3_publisher
    offer     = var.vm3_offer
    sku       = var.vm3_sku
    version   = var.vm3_version
  }

  tags = {
    Environment = var.tag_environment
    CreatedBy   = var.tag_createdby
    CreatedWith = var.tag_createdwith
    Project     = var.tag_project
  }
}

# Create VM 4
resource "azurerm_linux_virtual_machine" "vm4" {
  name                            = "vm-${var.vm4_name}"
  depends_on                      = [azurerm_key_vault.keyvault]
  resource_group_name             = azurerm_resource_group.rg_b.name
  location                        = azurerm_resource_group.rg_b.location
  size                            = var.vm4_size
  admin_username                  = azurerm_key_vault_secret.admin_secret.name
  admin_password                  = azurerm_key_vault_secret.admin_secret.value
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.nic_vm4.id,
  ]

  os_disk {
    caching              = var.disk_caching
    storage_account_type = var.storage_account_type
  }

  source_image_reference {
    publisher = var.vm4_publisher
    offer     = var.vm4_offer
    sku       = var.vm4_sku
    version   = var.vm4_version
  }

  tags = {
    Environment = var.tag_environment
    CreatedBy   = var.tag_createdby
    CreatedWith = var.tag_createdwith
    Project     = var.tag_project
  }
}

# Attach disk to VM3
resource "azurerm_virtual_machine_data_disk_attachment" "mdisk_vm3" {
  managed_disk_id    = azurerm_managed_disk.mdisk_vm3.id
  depends_on         = [azurerm_linux_virtual_machine.vm3]
  virtual_machine_id = azurerm_linux_virtual_machine.vm3.id
  lun                = "10"
  caching            = "None"
}

# Attach disk to VM4
resource "azurerm_virtual_machine_data_disk_attachment" "mdisk_vm4" {
  managed_disk_id    = azurerm_managed_disk.mdisk_vm4.id
  depends_on         = [azurerm_linux_virtual_machine.vm4]
  virtual_machine_id = azurerm_linux_virtual_machine.vm4.id
  lun                = "10"
  caching            = "None"
}