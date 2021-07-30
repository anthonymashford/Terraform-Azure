# Create VNet A
resource "azurerm_virtual_network" "vnet_a" {
  name                = "${var.vnet_a}-${var.region_a}"
  location            = var.region_a
  resource_group_name = azurerm_resource_group.rg_a.name
  address_space       = [var.address_space_region_a]
  dns_servers         = [var.dns_server_a, var.dns_server_b, var.dns_server_azure]
  tags = {
    Environment = var.tag_environment
    CreatedBy   = var.tag_createdby
    CreatedWith = var.tag_createdwith
    Project     = var.tag_project
  }
}

# Create VNet A Subnet A
resource "azurerm_subnet" "vnet_a_snet_a" {
  name                 = "${var.vnet_a}-${var.snet_a}-${var.region_a}"
  resource_group_name  = azurerm_resource_group.rg_a.name
  virtual_network_name = azurerm_virtual_network.vnet_a.name
  address_prefixes     = [var.address_vnet_a_snet_a]
}

# Create VNet A Subnet B
resource "azurerm_subnet" "vnet_a_snet_b" {
  name                 = "${var.vnet_a}-${var.snet_b}-${var.region_a}"
  resource_group_name  = azurerm_resource_group.rg_a.name
  virtual_network_name = azurerm_virtual_network.vnet_a.name
  address_prefixes     = [var.address_vnet_a_snet_b]
  delegation {
    name = "delegation"
    service_delegation {
      name    = "Microsoft.Netapp/volumes"
      actions = ["Microsoft.Network/networkinterfaces/*", "Microsoft.Network/virtualNetworks/subnets/join/action"]
    }
  }
}

# Create VNet B
resource "azurerm_virtual_network" "vnet_b" {
  name                = "${var.vnet_b}-${var.region_b}"
  location            = var.region_b
  resource_group_name = azurerm_resource_group.rg_b.name
  address_space       = [var.address_space_region_b]
  dns_servers         = [var.dns_server_a, var.dns_server_b, var.dns_server_azure]
  tags = {
    Environment = var.tag_environment
    CreatedBy   = var.tag_createdby
    CreatedWith = var.tag_createdwith
    Project     = var.tag_project
  }
}

# Create VNet B Subnet A
resource "azurerm_subnet" "vnet_b_snet_a" {
  name                 = "${var.vnet_b}-${var.snet_a}-${var.region_b}"
  resource_group_name  = azurerm_resource_group.rg_b.name
  virtual_network_name = azurerm_virtual_network.vnet_b.name
  address_prefixes     = [var.address_vnet_b_snet_a]
}

# Create VNet B Subnet B
resource "azurerm_subnet" "vnet_b_snet_b" {
  name                 = "${var.vnet_b}-${var.snet_b}-${var.region_b}"
  resource_group_name  = azurerm_resource_group.rg_b.name
  virtual_network_name = azurerm_virtual_network.vnet_b.name
  address_prefixes     = [var.address_vnet_b_snet_b]
  delegation {
    name = "delegation"
    service_delegation {
      name    = "Microsoft.Netapp/volumes"
      actions = ["Microsoft.Network/networkinterfaces/*", "Microsoft.Network/virtualNetworks/subnets/join/action"]
    }
  }
}

# Create VNet peering VNet A to B
resource "azurerm_virtual_network_peering" "a2b" {
  name                         = "peer-${var.vnet_a}-2-${var.vnet_b}"
  resource_group_name          = azurerm_resource_group.rg_a.name
  virtual_network_name         = azurerm_virtual_network.vnet_a.name
  remote_virtual_network_id    = azurerm_virtual_network.vnet_b.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}
resource "azurerm_virtual_network_peering" "b2a" {
  name                         = "peer-${var.vnet_b}-2-${var.vnet_a}"
  resource_group_name          = azurerm_resource_group.rg_b.name
  virtual_network_name         = azurerm_virtual_network.vnet_b.name
  remote_virtual_network_id    = azurerm_virtual_network.vnet_a.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}

# Get your IP address 
data "http" "clientip" {
  url = "https://ipv4.icanhazip.com/"
}

# Create Network Security Group Region A
resource "azurerm_network_security_group" "nsg_a" {
  name                = "nsg-${var.vnet_a}-${var.snet_a}"
  location            = var.region_a
  resource_group_name = azurerm_resource_group.rg_a.name

  security_rule {
    name                       = "RDP-In"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "${chomp(data.http.clientip.body)}/32"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "SSH-In"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "${chomp(data.http.clientip.body)}/32"
    destination_address_prefix = "*"
  }

  tags = {
    Environment = var.tag_environment
    CreatedBy   = var.tag_createdby
    CreatedWith = var.tag_createdwith
    Project     = var.tag_project
  }
}

# Create Network Security Group Region B
resource "azurerm_network_security_group" "nsg_b" {
  name                = "nsg-${var.vnet_b}-${var.snet_a}"
  location            = var.region_b
  resource_group_name = azurerm_resource_group.rg_b.name

  security_rule {
    name                       = "RDP-In"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "${chomp(data.http.clientip.body)}/32"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "SSH-In"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "${chomp(data.http.clientip.body)}/32"
    destination_address_prefix = "*"
  }

  tags = {
    Environment = var.tag_environment
    CreatedBy   = var.tag_createdby
    CreatedWith = var.tag_createdwith
    Project     = var.tag_project
  }
}

resource "azurerm_subnet_network_security_group_association" "nsg_vnet_a_snet_a" {
  subnet_id                 = azurerm_subnet.vnet_a_snet_a.id
  network_security_group_id = azurerm_network_security_group.nsg_a.id
}

resource "azurerm_subnet_network_security_group_association" "nsg_vnet_b_snet_a" {
  subnet_id                 = azurerm_subnet.vnet_b_snet_a.id
  network_security_group_id = azurerm_network_security_group.nsg_b.id
}