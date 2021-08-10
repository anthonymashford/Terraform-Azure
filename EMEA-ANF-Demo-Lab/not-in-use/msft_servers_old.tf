
# Create Public IP for VM1
resource "azurerm_public_ip" "pip_vm1" {
  name                = "pip-${var.vm1_name}"
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

# Create Public IP for VM2
resource "azurerm_public_ip" "pip_vm2" {
  name                = "pip-${var.vm2_name}"
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

# Create NIC for VM1
resource "azurerm_network_interface" "nic_vm1" {
  name                = "nic-${var.vm1_name}"
  location            = azurerm_resource_group.rg_1.location
  resource_group_name = azurerm_resource_group.rg_1.name


  ip_configuration {
    name                          = "ipconfig-${var.vm1_name}"
    subnet_id                     = azurerm_subnet.vnet_1_snet_1.id
    private_ip_address_allocation = var.nic_ip_allocation
    #private_ip_address            = var.vm1_ip_address
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
  location            = azurerm_resource_group.rg_2.location
  resource_group_name = azurerm_resource_group.rg_2.name


  ip_configuration {
    name                          = "ipconfig-${var.vm2_name}"
    subnet_id                     = azurerm_subnet.vnet_2_snet_1.id
    private_ip_address_allocation = var.nic_ip_allocation
    #private_ip_address            = var.vm2_ip_address
    public_ip_address_id          = azurerm_public_ip.pip_vm2.id
  }

  tags = {
    Environment = var.tag_environment
    CreatedBy   = var.tag_createdby
    CreatedWith = var.tag_createdwith
    Project     = var.tag_project
  }

}