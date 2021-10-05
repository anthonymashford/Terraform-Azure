# Create VNet peering VNet 1 to 2
resource "azurerm_virtual_network_peering" "peer-1-to-2" {
  name                         = "peer-${var.vnet_1}-to-${var.vnet_2}"
  resource_group_name          = azurerm_resource_group.rg_1.name
  virtual_network_name         = azurerm_virtual_network.vnet_1.name
  remote_virtual_network_id    = azurerm_virtual_network.vnet_2.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}
resource "azurerm_virtual_network_peering" "peer-2-to-1" {
  name                         = "peer-${var.vnet_2}-to-${var.vnet_1}"
  resource_group_name          = azurerm_resource_group.rg_2.name
  virtual_network_name         = azurerm_virtual_network.vnet_2.name
  remote_virtual_network_id    = azurerm_virtual_network.vnet_1.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}

# Create VNet peering Vnet 1 to UKS
resource "azurerm_virtual_network_peering" "peer-1-to-uks" {
  name                         = "peer-${var.vnet_1}-to-hub-uks"
  resource_group_name          = azurerm_resource_group.rg_1.name
  virtual_network_name         = azurerm_virtual_network.vnet_1.name
  remote_virtual_network_id    = data.azurerm_virtual_network.hub_uks.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}

resource "azurerm_virtual_network_peering" "peer-uks-to-1" {
  name                         = "peer-hub-uks-to-${var.vnet_1}"
  resource_group_name          = data.azurerm_resource_group.rg_uks.name
  virtual_network_name         = data.azurerm_virtual_network.hub_uks.name
  remote_virtual_network_id    = azurerm_virtual_network.vnet_1.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}

# Create VNet peering Vnet 1 to UKW
resource "azurerm_virtual_network_peering" "peer-1-to-ukw" {
  name                         = "peer-${var.vnet_1}-to-hub-ukw"
  resource_group_name          = azurerm_resource_group.rg_1.name
  virtual_network_name         = azurerm_virtual_network.vnet_1.name
  remote_virtual_network_id    = data.azurerm_virtual_network.hub_ukw.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}

resource "azurerm_virtual_network_peering" "peer-ukw-to-1" {
  name                         = "peer-hub-ukw-to-${var.vnet_1}"
  resource_group_name          = data.azurerm_resource_group.rg_ukw.name
  virtual_network_name         = data.azurerm_virtual_network.hub_ukw.name
  remote_virtual_network_id    = azurerm_virtual_network.vnet_1.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}

# Create VNet peering Vnet 1 to NEU
resource "azurerm_virtual_network_peering" "peer-1-to-neu" {
  name                         = "peer-${var.vnet_1}-to-hub-neu"
  resource_group_name          = azurerm_resource_group.rg_1.name
  virtual_network_name         = azurerm_virtual_network.vnet_1.name
  remote_virtual_network_id    = data.azurerm_virtual_network.hub_neu.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}

resource "azurerm_virtual_network_peering" "peer-neu-to-1" {
  name                         = "peer-hub-neu-to-${var.vnet_1}"
  resource_group_name          = data.azurerm_resource_group.rg_neu.name
  virtual_network_name         = data.azurerm_virtual_network.hub_neu.name
  remote_virtual_network_id    = azurerm_virtual_network.vnet_1.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}

# Create VNet peering Vnet 1 to WEU
resource "azurerm_virtual_network_peering" "peer-1-to-weu" {
  name                         = "peer-${var.vnet_1}-to-hub-weu"
  resource_group_name          = azurerm_resource_group.rg_1.name
  virtual_network_name         = azurerm_virtual_network.vnet_1.name
  remote_virtual_network_id    = data.azurerm_virtual_network.hub_weu.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}

resource "azurerm_virtual_network_peering" "peer-weu-to-1" {
  name                         = "peer-hub-weu-to-${var.vnet_1}"
  resource_group_name          = data.azurerm_resource_group.rg_weu.name
  virtual_network_name         = data.azurerm_virtual_network.hub_weu.name
  remote_virtual_network_id    = azurerm_virtual_network.vnet_1.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}

# Create VNet peering Vnet 2 to UKS
resource "azurerm_virtual_network_peering" "peer-2-to-uks" {
  name                         = "peer-${var.vnet_2}-to-hub-uks"
  resource_group_name          = azurerm_resource_group.rg_2.name
  virtual_network_name         = azurerm_virtual_network.vnet_2.name
  remote_virtual_network_id    = data.azurerm_virtual_network.hub_uks.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}

resource "azurerm_virtual_network_peering" "peer-uks-to-2" {
  name                         = "peer-hub-uks-to-${var.vnet_2}"
  resource_group_name          = data.azurerm_resource_group.rg_uks.name
  virtual_network_name         = data.azurerm_virtual_network.hub_uks.name
  remote_virtual_network_id    = azurerm_virtual_network.vnet_2.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}

# Create VNet peering Vnet 2 to UKW
resource "azurerm_virtual_network_peering" "peer-2-to-ukw" {
  name                         = "peer-${var.vnet_2}-to-hub-ukw"
  resource_group_name          = azurerm_resource_group.rg_2.name
  virtual_network_name         = azurerm_virtual_network.vnet_2.name
  remote_virtual_network_id    = data.azurerm_virtual_network.hub_ukw.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}

resource "azurerm_virtual_network_peering" "peer-ukw-to-2" {
  name                         = "peer-hub-ukw-to-${var.vnet_2}"
  resource_group_name          = data.azurerm_resource_group.rg_ukw.name
  virtual_network_name         = data.azurerm_virtual_network.hub_ukw.name
  remote_virtual_network_id    = azurerm_virtual_network.vnet_2.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}

# Create VNet peering Vnet 2 to NEU
resource "azurerm_virtual_network_peering" "peer-2-to-neu" {
  name                         = "peer-${var.vnet_2}-to-hub-neu"
  resource_group_name          = azurerm_resource_group.rg_2.name
  virtual_network_name         = azurerm_virtual_network.vnet_2.name
  remote_virtual_network_id    = data.azurerm_virtual_network.hub_neu.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}

resource "azurerm_virtual_network_peering" "peer-neu-to-2" {
  name                         = "peer-hub-neu-to-${var.vnet_2}"
  resource_group_name          = data.azurerm_resource_group.rg_neu.name
  virtual_network_name         = data.azurerm_virtual_network.hub_neu.name
  remote_virtual_network_id    = azurerm_virtual_network.vnet_2.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}

# Create VNet peering Vnet 2 to WEU
resource "azurerm_virtual_network_peering" "peer-2-to-weu" {
  name                         = "peer-${var.vnet_2}-to-hub-weu"
  resource_group_name          = azurerm_resource_group.rg_2.name
  virtual_network_name         = azurerm_virtual_network.vnet_2.name
  remote_virtual_network_id    = data.azurerm_virtual_network.hub_weu.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}

resource "azurerm_virtual_network_peering" "peer-weu-to-2" {
  name                         = "peer-hub-weu-to-${var.vnet_2}"
  resource_group_name          = data.azurerm_resource_group.rg_weu.name
  virtual_network_name         = data.azurerm_virtual_network.hub_weu.name
  remote_virtual_network_id    = azurerm_virtual_network.vnet_2.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}