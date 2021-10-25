# Create random string for VM 1
resource "random_string" "vm_rs_1" {
  length  = 5
  special = false
}

# Create Public IP for VM1
resource "azurerm_public_ip" "pip_vm1" {
  name                = "pip-${var.vm1_name}-${random_string.vm_rs_1.result}"
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

# Create NIC for VM1
resource "azurerm_network_interface" "nic_vm1" {
  name                = "nic-${var.vm1_name}-${random_string.vm_rs_1.result}"
  location            = azurerm_resource_group.rg_1.location
  resource_group_name = azurerm_resource_group.rg_1.name


  ip_configuration {
    name                          = "ipconfig-${var.vm1_name}-${random_string.vm_rs_1.result}"
    subnet_id                     = azurerm_subnet.vnet_1_snet_1.id
    private_ip_address_allocation = var.nic_ip_allocation
    public_ip_address_id          = azurerm_public_ip.pip_vm1.id
  }

  tags = {
    Environment = var.tag_environment
    CreatedBy   = var.tag_createdby
    CreatedWith = var.tag_createdwith
    Project     = var.tag_project
  }

}

# Create VM 1
resource "azurerm_windows_virtual_machine" "vm1" {
  name                = "vm-${var.vm1_name}-${random_string.vm_rs_1.result}"
  depends_on          = [azurerm_key_vault.keyvault]
  resource_group_name = azurerm_resource_group.rg_1.name
  location            = azurerm_resource_group.rg_1.location
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

# Install apps for test & demo

resource "azurerm_virtual_machine_extension" "apps1" {
  name                 = "install-apps"
  virtual_machine_id   = azurerm_windows_virtual_machine.vm1.id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.9"

  protected_settings = <<PROTECTED_SETTINGS
    {
      "commandToExecute": "powershell.exe -Command \"./install_apps.ps1; exit 0;\""
    }
  PROTECTED_SETTINGS

  settings = <<SETTINGS
    {
        "fileUris": [
          "https://raw.githubusercontent.com/anthonymashford/Terraform-Azure/main/EMEA-ANF-Demo-Lab/PowerShell/install_apps.ps1"
        ]
    }
  SETTINGS
}

# Join Demo VM 1 to Domain
# Please note that the domain settings are bespoke to your individual environment. Please adjust them to suit.
resource "azurerm_virtual_machine_extension" "domjoin1" {
  depends_on = [ #azurerm_virtual_machine_extension.apps1,
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
  virtual_machine_id   = azurerm_windows_virtual_machine.vm1.id
  publisher            = "Microsoft.Compute"
  type                 = "JsonADDomainExtension"
  type_handler_version = "1.3"
  settings             = <<SETTINGS
        {
            "Name": "anf.test",
            "OUPath": "OU=anf-demo,DC=anf,DC=test",
            "User": "YOUR DOMAIN NAME\\USERNAME",
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

# Create random string for VM 2
resource "random_string" "vm_rs_2" {
  length  = 5
  special = false
}

# Create Public IP for VM2
resource "azurerm_public_ip" "pip_vm2" {
  name                = "pip-${var.vm2_name}-${random_string.vm_rs_2.result}"
  resource_group_name = azurerm_resource_group.rg_2.name
  location            = azurerm_resource_group.rg_2.location
  allocation_method   = var.pip_allocation
  sku                 = var.pip_sku

  tags = {
    Environment = var.tag_environment
    CreatedBy   = var.tag_createdby
    CreatedWith = var.tag_createdwith
    Project     = var.tag_project
  }
}

# Create NIC for VM2
resource "azurerm_network_interface" "nic_vm2" {
  name                = "nic-${var.vm2_name}-${random_string.vm_rs_2.result}"
  location            = azurerm_resource_group.rg_2.location
  resource_group_name = azurerm_resource_group.rg_2.name


  ip_configuration {
    name                          = "ipconfig-${var.vm2_name}-${random_string.vm_rs_2.result}"
    subnet_id                     = azurerm_subnet.vnet_2_snet_1.id
    private_ip_address_allocation = var.nic_ip_allocation
    #private_ip_address            = var.vm2_ip_address
    public_ip_address_id = azurerm_public_ip.pip_vm2.id
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
  name                = "vm-${var.vm2_name}-${random_string.vm_rs_2.result}"
  depends_on          = [azurerm_key_vault.keyvault]
  resource_group_name = azurerm_resource_group.rg_2.name
  location            = azurerm_resource_group.rg_2.location
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

# Install apps for test & demo

resource "azurerm_virtual_machine_extension" "apps2" {
  name                 = "install-apps"
  virtual_machine_id   = azurerm_windows_virtual_machine.vm2.id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.9"

  protected_settings = <<PROTECTED_SETTINGS
    {
      "commandToExecute": "powershell.exe -Command \"./install_apps.ps1; exit 0;\""
    }
  PROTECTED_SETTINGS

  settings = <<SETTINGS
    {
        "fileUris": [
          "https://raw.githubusercontent.com/anthonymashford/Terraform-Azure/main/EMEA-ANF-Demo-Lab/PowerShell/install_apps.ps1"
        ]
    }
  SETTINGS
}

# Join Demo VM 2 to Domain
# Please note that the domain settings are bespoke to your individual environment. Please adjust them to suit.
resource "azurerm_virtual_machine_extension" "domjoin2" {
  depends_on = [ #azurerm_virtual_machine_extension.apps2,
    azurerm_virtual_network_peering.peer-2-to-uks,
    azurerm_virtual_network_peering.peer-uks-to-2,
    azurerm_virtual_network_peering.peer-2-to-ukw,
    azurerm_virtual_network_peering.peer-ukw-to-2,
    azurerm_virtual_network_peering.peer-2-to-neu,
    azurerm_virtual_network_peering.peer-neu-to-2,
    azurerm_virtual_network_peering.peer-2-to-weu,
    azurerm_virtual_network_peering.peer-weu-to-2,
  ]
  name                 = "domjoin"
  virtual_machine_id   = azurerm_windows_virtual_machine.vm2.id
  publisher            = "Microsoft.Compute"
  type                 = "JsonADDomainExtension"
  type_handler_version = "1.3"
  settings             = <<SETTINGS
        {
            "Name": "anf.test",
            "OUPath": "OU=anf-demo,DC=anf,DC=test",
            "User": "YOUR DOMAIN NAME\\USERNAME",
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

# Create random string for VM 3
resource "random_string" "vm_rs_3" {
  length  = 5
  special = false
}

# Create Public IP for VM 3
resource "azurerm_public_ip" "pip_vm3" {
  name                = "pip-${var.vm3_name}-${random_string.vm_rs_3.result}"
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

# Create NIC for Linux VM 3
resource "azurerm_network_interface" "nic_vm3" {
  name                = "nic-${var.vm3_name}-${random_string.vm_rs_3.result}"
  location            = azurerm_resource_group.rg_1.location
  resource_group_name = azurerm_resource_group.rg_1.name

  ip_configuration {
    name                          = "ipconfig-${var.vm3_name}-${random_string.vm_rs_3.result}"
    subnet_id                     = azurerm_subnet.vnet_1_snet_1.id
    private_ip_address_allocation = var.nic_ip_allocation
    public_ip_address_id          = azurerm_public_ip.pip_vm3.id
  }

  tags = {
    Environment = var.tag_environment
    CreatedBy   = var.tag_createdby
    CreatedWith = var.tag_createdwith
    Project     = var.tag_project
  }

}

# Create VM 3
resource "azurerm_linux_virtual_machine" "vm3" {
  name                            = "vm-${var.vm3_name}-${random_string.vm_rs_3.result}"
  depends_on                      = [azurerm_key_vault.keyvault]
  resource_group_name             = azurerm_resource_group.rg_1.name
  location                        = azurerm_resource_group.rg_1.location
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

# Install NFS & Samba services

resource "azurerm_virtual_machine_extension" "apps3" {
  depends_on           = [azurerm_linux_virtual_machine.vm3]
  name                 = "install-linux-services"
  virtual_machine_id   = azurerm_linux_virtual_machine.vm3.id
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.0"

  settings = <<SETTINGS
    {
        "script": "${filebase64("./ShellScripts/install_services.sh")}"
    }
  SETTINGS
}

# Create random string for VM 4
resource "random_string" "vm_rs_4" {
  length  = 5
  special = false
}

# Create Public IP for VM 4
resource "azurerm_public_ip" "pip_vm4" {
  name                = "pip-${var.vm4_name}-${random_string.vm_rs_4.result}"
  resource_group_name = azurerm_resource_group.rg_2.name
  location            = azurerm_resource_group.rg_2.location
  allocation_method   = var.pip_allocation
  sku                 = var.pip_sku

  tags = {
    Environment = var.tag_environment
    CreatedBy   = var.tag_createdby
    CreatedWith = var.tag_createdwith
    Project     = var.tag_project
  }
}

# Create NIC for Linux VM 4
resource "azurerm_network_interface" "nic_vm4" {
  name                = "nic-${var.vm4_name}-${random_string.vm_rs_4.result}"
  location            = azurerm_resource_group.rg_2.location
  resource_group_name = azurerm_resource_group.rg_2.name

  ip_configuration {
    name                          = "ipconfig-${var.vm4_name}-${random_string.vm_rs_4.result}"
    subnet_id                     = azurerm_subnet.vnet_2_snet_1.id
    private_ip_address_allocation = var.nic_ip_allocation
    public_ip_address_id          = azurerm_public_ip.pip_vm4.id
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
  name                            = "vm-${var.vm4_name}-${random_string.vm_rs_4.result}"
  depends_on                      = [azurerm_key_vault.keyvault]
  resource_group_name             = azurerm_resource_group.rg_2.name
  location                        = azurerm_resource_group.rg_2.location
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

# Install NFS & Samba services

resource "azurerm_virtual_machine_extension" "apps4" {
  depends_on           = [azurerm_linux_virtual_machine.vm4]
  name                 = "install-linux-services"
  virtual_machine_id   = azurerm_linux_virtual_machine.vm4.id
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.0"

  settings = <<SETTINGS
    {
        "script": "${filebase64("./ShellScripts/install_services.sh")}"
    }
  SETTINGS
}