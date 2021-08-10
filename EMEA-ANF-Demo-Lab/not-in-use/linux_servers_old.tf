# Create Public IP for VM 3
resource "azurerm_public_ip" "pip_vm3" {
  name                = "pip-${var.vm3_name}"
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

# Create Public IP for VM 4
resource "azurerm_public_ip" "pip_vm4" {
  name                = "pip-${var.vm4_name}"
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

# Create NIC for Linux VM 3
resource "azurerm_network_interface" "nic_vm3" {
  name                = "nic-${var.vm3_name}"
  location            = azurerm_resource_group.rg_1.location
  resource_group_name = azurerm_resource_group.rg_1.name

  ip_configuration {
    name                          = "ipconfig-${var.vm3_name}"
    subnet_id                     = azurerm_subnet.vnet_1_snet_1.id
    private_ip_address_allocation = var.nic_ip_allocation
    #private_ip_address            = var.vm3_ip_address
    public_ip_address_id          = azurerm_public_ip.pip_vm1.id
  }

  tags = {
    Environment = var.tag_environment
    CreatedBy   = var.tag_createdby
    CreatedWith = var.tag_createdwith
    Project     = var.tag_project
  }

}

# Create NIC for Linux VM 4
resource "azurerm_network_interface" "nic_vm4" {
  name                = "nic-${var.vm4_name}"
  location            = azurerm_resource_group.rg_2.location
  resource_group_name = azurerm_resource_group.rg_2.name

  ip_configuration {
    name                          = "ipconfig-${var.vm4_name}"
    subnet_id                     = azurerm_subnet.vnet_2_snet_1.id
    private_ip_address_allocation = var.nic_ip_allocation
    #private_ip_address            = var.vm4_ip_address
    public_ip_address_id          = azurerm_public_ip.pip_vm2.id
  }

  tags = {
    Environment = var.tag_environment
    CreatedBy   = var.tag_createdby
    CreatedWith = var.tag_createdwith
    Project     = var.tag_project
  }

}
