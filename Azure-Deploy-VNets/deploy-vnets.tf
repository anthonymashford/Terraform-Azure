# Create random string for UKS resource group name
resource "random_string" "rg_random_uks" {
  length  = 16
  special = false
}

# Create UKS vnet resource group
resource "azurerm_resource_group" "rg_vnet_uks" {
  name     = "rg-${var.prefix}-${var.region_uks}-${random_string.rg_random_uks.result}"
  location = var.region_uks
  tags = {
    Environment = var.tag_environment
    CreatedBy   = var.tag_createdby
    CreatedWith = var.tag_createdwith
  }
}

# Create UKS virtual network
resource "azurerm_virtual_network" "vnet_uks" {
  resource_group_name = azurerm_resource_group.rg_vnet_uks.name
  name                = "${var.prefix}-${var.vnet_name_uks}"
  location            = azurerm_resource_group.rg_vnet_uks.location
  address_space       = [var.vnet_address_space_uks]
  dns_servers         = [var.dns_server_uks, 
                          var.dns_server_ukw, 
                          var.dns_server_neu, 
                          var.dns_server_weu,
                          var.dns_server_azure]
  tags                = {
    Environment       = var.tag_environment
    CreatedBy         = var.tag_createdby
    CreatedWith       = var.tag_createdwith
  }
}

# Create UKS servers subnet
resource "azurerm_subnet" "servers_subnet_uks" {
  name                 = "${var.prefix}-${var.servers_subnet_name_uks}"
  resource_group_name  = azurerm_resource_group.rg_vnet_uks.name
  virtual_network_name = azurerm_virtual_network.vnet_uks.name
  address_prefixes     = [var.servers_subnet_address_uks]
}

# Create UKS anf subnet
resource "azurerm_subnet" "anf_subnet_uks" {
  name                 = "${var.prefix}-${var.anf_subnet_name_uks}"
  resource_group_name  = azurerm_resource_group.rg_vnet_uks.name
  virtual_network_name = azurerm_virtual_network.vnet_uks.name
  address_prefixes     = [var.anf_subnet_address_uks]
  delegation {
    name = "netapp"
    service_delegation {
      name    = "Microsoft.Netapp/volumes"
      actions = ["Microsoft.Network/networkinterfaces/*", "Microsoft.Network/virtualNetworks/subnets/join/action"]
    }
  }
}

# Create random string for UKW resource group name
resource "random_string" "rg_random_ukw" {
  length  = 16
  special = false
}

# Create UKW vnet resource group
resource "azurerm_resource_group" "rg_vnet_ukw" {
  name     = "rg-${var.prefix}-${var.region_ukw}-${random_string.rg_random_ukw.result}"
  location = var.region_ukw
  tags = {
    Environment = var.tag_environment
    CreatedBy   = var.tag_createdby
    CreatedWith = var.tag_createdwith
  }
}

# Create UKW virtual network
resource "azurerm_virtual_network" "vnet_ukw" {
  resource_group_name = azurerm_resource_group.rg_vnet_ukw.name
  name                = "${var.prefix}-${var.vnet_name_ukw}"
  location            = azurerm_resource_group.rg_vnet_ukw.location
  address_space       = [var.vnet_address_space_ukw]
  dns_servers         = [var.dns_server_uks, 
                          var.dns_server_ukw, 
                          var.dns_server_neu, 
                          var.dns_server_weu,
                          var.dns_server_azure]
  tags                = {
    Environment       = var.tag_environment
    CreatedBy         = var.tag_createdby
    CreatedWith       = var.tag_createdwith
  }
}

# Create UKW servers subnet
resource "azurerm_subnet" "servers_subnet_ukw" {
  name                 = "${var.prefix}-${var.servers_subnet_name_ukw}"
  resource_group_name  = azurerm_resource_group.rg_vnet_ukw.name
  virtual_network_name = azurerm_virtual_network.vnet_ukw.name
  address_prefixes     = [var.servers_subnet_address_ukw]
}

# Create UKW anf subnet
resource "azurerm_subnet" "anf_subnet_ukw" {
  name                 = "${var.prefix}-${var.anf_subnet_name_ukw}"
  resource_group_name  = azurerm_resource_group.rg_vnet_ukw.name
  virtual_network_name = azurerm_virtual_network.vnet_ukw.name
  address_prefixes     = [var.anf_subnet_address_ukw]
  delegation {
    name = "netapp"
    service_delegation {
      name    = "Microsoft.Netapp/volumes"
      actions = ["Microsoft.Network/networkinterfaces/*", "Microsoft.Network/virtualNetworks/subnets/join/action"]
    }
  }
}

# Create random string for NEU resource group name
resource "random_string" "rg_random_neu" {
  length  = 16
  special = false
}

# Create NEU vnet resource group
resource "azurerm_resource_group" "rg_vnet_neu" {
  name     = "rg-${var.prefix}-${var.region_neu}-${random_string.rg_random_neu.result}"
  location = var.region_neu
  tags = {
    Environment = var.tag_environment
    CreatedBy   = var.tag_createdby
    CreatedWith = var.tag_createdwith
  }
}

# Create NEU virtual network
resource "azurerm_virtual_network" "vnet_neu" {
  resource_group_name = azurerm_resource_group.rg_vnet_neu.name
  name                = "${var.prefix}-${var.vnet_name_neu}"
  location            = azurerm_resource_group.rg_vnet_neu.location
  address_space       = [var.vnet_address_space_neu]
  dns_servers         = [var.dns_server_uks, 
                          var.dns_server_ukw, 
                          var.dns_server_neu, 
                          var.dns_server_weu,
                          var.dns_server_azure]
  tags                = {
    Environment       = var.tag_environment
    CreatedBy         = var.tag_createdby
    CreatedWith       = var.tag_createdwith
  }
}

# Create NEU servers subnet
resource "azurerm_subnet" "servers_subnet_neu" {
  name                 = "${var.prefix}-${var.servers_subnet_name_neu}"
  resource_group_name  = azurerm_resource_group.rg_vnet_neu.name
  virtual_network_name = azurerm_virtual_network.vnet_neu.name
  address_prefixes     = [var.servers_subnet_address_neu]
}

# Create NEU anf subnet
resource "azurerm_subnet" "anf_subnet_neu" {
  name                 = "${var.prefix}-${var.anf_subnet_name_neu}"
  resource_group_name  = azurerm_resource_group.rg_vnet_neu.name
  virtual_network_name = azurerm_virtual_network.vnet_neu.name
  address_prefixes     = [var.anf_subnet_address_neu]
  delegation {
    name = "netapp"
    service_delegation {
      name    = "Microsoft.Netapp/volumes"
      actions = ["Microsoft.Network/networkinterfaces/*", "Microsoft.Network/virtualNetworks/subnets/join/action"]
    }
  }
}

# Create random string for WEU resource group name
resource "random_string" "rg_random_weu" {
  length  = 16
  special = false
}

# Create WEU vnet resource group
resource "azurerm_resource_group" "rg_vnet_weu" {
  name     = "rg-${var.prefix}-${var.region_weu}-${random_string.rg_random_weu.result}"
  location = var.region_weu
  tags = {
    Environment = var.tag_environment
    CreatedBy   = var.tag_createdby
    CreatedWith = var.tag_createdwith
  }
}

# Create WEU virtual network
resource "azurerm_virtual_network" "vnet_weu" {
  resource_group_name = azurerm_resource_group.rg_vnet_weu.name
  name                = "${var.prefix}-${var.vnet_name_weu}"
  location            = azurerm_resource_group.rg_vnet_weu.location
  address_space       = [var.vnet_address_space_weu]
  dns_servers         = [var.dns_server_uks, 
                          var.dns_server_ukw, 
                          var.dns_server_neu, 
                          var.dns_server_weu,
                          var.dns_server_azure]
  tags                = {
    Environment       = var.tag_environment
    CreatedBy         = var.tag_createdby
    CreatedWith       = var.tag_createdwith
  }
}

# Create WEU servers subnet
resource "azurerm_subnet" "servers_subnet_weu" {
  name                 = "${var.prefix}-${var.servers_subnet_name_weu}"
  resource_group_name  = azurerm_resource_group.rg_vnet_weu.name
  virtual_network_name = azurerm_virtual_network.vnet_weu.name
  address_prefixes     = [var.servers_subnet_address_weu]
}

# Create WEU anf subnet
resource "azurerm_subnet" "anf_subnet_weu" {
  name                 = "${var.prefix}-${var.anf_subnet_name_weu}"
  resource_group_name  = azurerm_resource_group.rg_vnet_weu.name
  virtual_network_name = azurerm_virtual_network.vnet_weu.name
  address_prefixes     = [var.anf_subnet_address_weu]
  delegation {
    name = "netapp"
    service_delegation {
      name    = "Microsoft.Netapp/volumes"
      actions = ["Microsoft.Network/networkinterfaces/*", "Microsoft.Network/virtualNetworks/subnets/join/action"]
    }
  }
}