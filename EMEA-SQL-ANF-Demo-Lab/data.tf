# Get Resource Group Details
data "azurerm_resource_group" "rg_demo_lab" {
  name = "rg-emea-demo-lab-resources"
}

# Get Keyvault Details
data "azurerm_key_vault" "key_vault" {
  name                = "keyvault-demo-lab"
  resource_group_name = "rg-emea-demo-lab-resources"
}

# Get ANF Password from Keyvault
data "azurerm_key_vault_secret" "join" {
  name         = "join"
  key_vault_id = data.azurerm_key_vault.key_vault.id
}

# Get VNet EU North Resource Group Details
data "azurerm_resource_group" "rg_neu" {
  name = "emea-core-north-europe"
}

# Get VNet EU North Details
data "azurerm_virtual_network" "hub_neu" {
  name                = "eu-north-hub"
  resource_group_name = "emea-core-north-europe"
}

# Get VNet EU West Resource Group Details
data "azurerm_resource_group" "rg_weu" {
  name = "emea-core-west-europe"
}

# Get VNet EU West Details
data "azurerm_virtual_network" "hub_weu" {
  name                = "eu-west-hub"
  resource_group_name = "emea-core-west-europe"
}

# Get VNet UK South Resource Group Details
data "azurerm_resource_group" "rg_uks" {
  name = "emea-core-south-uk"
}

# Get VNet UK South Details
data "azurerm_virtual_network" "hub_uks" {
  name                = "uk-south-hub"
  resource_group_name = "emea-core-south-uk"
}

# Get VNet UK West Resource Group Details
data "azurerm_resource_group" "rg_ukw" {
  name = "emea-core-west-uk"
}

# Get VNet UK West Details
data "azurerm_virtual_network" "hub_ukw" {
  name                = "uk-west-hub"
  resource_group_name = "emea-core-west-uk"
}

# Get North Europe ANF
data "azurerm_netapp_account" "anf_neu" {
  name                = "core-north-europe"
  resource_group_name = "emea-core-north-europe-anf"
}

# Get West Europe ANF
data "azurerm_netapp_account" "anf_weu" {
  name                = "core-west-europe"
  resource_group_name = "emea-core-west-europe-anf"
}

# Get UK South ANF
data "azurerm_netapp_account" "anf_uks" {
  name                = "core-south-uk"
  resource_group_name = "emea-core-south-uk-anf"
}

# Get UK West ANF
data "azurerm_netapp_account" "anf_ukw" {
  name                = "core-west-uk"
  resource_group_name = "emea-core-west-uk-anf"
}