###########################################################################
#                               Outputs                                   #
###########################################################################

output "rg_1_name" {
  description = "Resource Group 1 Name"
  value       = azurerm_resource_group.rg_1.name
}

output "rg_2_name" {
  description = "Resource Group 2 Name"
  value       = azurerm_resource_group.rg_2.name
}

output "vnet_1_name" {
  description = "VNet 1 Name"
  value       = azurerm_virtual_network.vnet_1.name
}

output "vnet_2_name" {
  description = "VNet 2 Name"
  value       = azurerm_virtual_network.vnet_2.name
}

output "vnet_1_snet_1" {
  description = "Subnet Name"
  value       = azurerm_subnet.vnet_1_snet_1.name
}

output "vnet_1_snet_2" {
  description = "Subnet Name"
  value       = azurerm_subnet.vnet_1_snet_2.name
}

output "vnet_2_snet_1" {
  description = "Subnet Name"
  value       = azurerm_subnet.vnet_2_snet_1.name
}

output "vnet_2_snet_2" {
  description = "Subnet Name"
  value       = azurerm_subnet.vnet_2_snet_2.name
}

output "peer_1_to_2" {
  description = "Peering"
  value       = azurerm_virtual_network_peering.peer-1-to-2.name
}

output "peer_2_to_1" {
  description = "Peering"
  value       = azurerm_virtual_network_peering.peer-2-to-1.name
}

output "keyvault_name" {
  description = "Keyvault"
  value       = azurerm_key_vault.keyvault.name
}
/*
output "netapp-volume-smb-1" {
  value = azurerm_netapp_volume.anf_smb_vol_1
}
*/