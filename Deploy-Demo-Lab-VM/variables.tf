variable "prefix" {
  description = "Prefix to append to resources. e.g Customer Name"
  default     = ""
}
variable "labadmin" {
  description = "VM4 name"
  default     = ""
}
variable "region_a" {
  description = "Azure region A"
  default     = ""
}
variable "region_b" {
  description = "Azure region B"
  default     = ""
}
variable "rg_a_name" {
  description = "RG A"
  default     = ""
}
variable "rg_b_name" {
  description = "RG B"
  default     = ""
}
variable "rg_c_name" {
  description = "RG C"
  default     = ""
}
variable "tag_environment" {
  description = "Environment designation"
}
variable "tag_createdby" {
  description = "Resource created by this user"
  default     = ""
}
variable "tag_createdwith" {
  description = "Resource created using this method"
  default     = ""
}
variable "tag_project" {
  description = "Required to create resource in WWFCO EMEA CSA Subscription"
  default     = ""
}
variable "vnet_a" {
  description = "VNet A name"
  default     = ""
}
variable "vnet_b" {
  description = "VNet B name"
  default     = ""
}
variable "address_space_region_a" {
  description = "VNet address space region A"
  default     = ""
}
variable "address_space_region_b" {
  description = "VNet address space region B"
  default     = ""
}
variable "dns_server_a" {
  description = "DNS server A"
  default     = ""
}
variable "dns_server_b" {
  description = "DNS server B"
  default     = ""
}
variable "dns_server_azure" {
  description = "Azure DNS server IP"
  default     = ""
}
variable "snet_a" {
  description = "Subnet A"
  default     = ""
}
variable "snet_b" {
  description = "Subnet B"
  default     = ""
}
variable "address_vnet_a_snet_a" {
  description = "Subnet Address"
  default     = ""
}
variable "address_vnet_a_snet_b" {
  description = "Subnet Address"
  default     = ""
}
variable "address_vnet_b_snet_a" {
  description = "Subnet Address"
  default     = ""
}
variable "address_vnet_b_snet_b" {
  description = "Subnet Address"
  default     = ""
}
variable "vm1_name" {
  description = "VM1 name"
  default     = ""
}
variable "vm2_name" {
  description = "VM2 name"
  default     = ""
}
variable "vm3_name" {
  description = "VM3 name"
  default     = ""
}
variable "vm4_name" {
  description = "VM4 name"
  default     = ""
}
variable "pip_allocation" {
  description = "pip ip allocation"
  default     = ""
}
variable "pip_sku" {
  description = "pip sku"
  default     = ""
}
variable "nic_ip_allocation" {
  description = "NIC IP allocation"
  default     = ""
}
variable "storage_account_type" {
  description = "Storage account type"
  default     = ""
}
variable "create_option" {
  description = "Create empty desk"
  default     = ""
}
variable "disk_size_gb" {
  description = "Disk size"
  default     = ""
}
variable "disk_caching" {
  description = "Disk size"
  default     = ""
}
variable "vm1_ip_address" {
  description = "Disk size"
  default     = ""
}
variable "vm2_ip_address" {
  description = "Disk size"
  default     = ""
}
variable "vm3_ip_address" {
  description = "Disk size"
  default     = ""
}
variable "vm4_ip_address" {
  description = "Disk size"
  default     = ""
}
variable "vm1_size" {
  description = "VM Size"
  default     = ""
}
variable "vm2_size" {
  description = "VM Size"
  default     = ""
}
variable "vm3_size" {
  description = "VM Size"
  default     = ""
}
variable "vm4_size" {
  description = "VM Size"
  default     = ""
}
variable "vm1_publisher" {
  description = "VM Publisher"
  default     = ""
}
variable "vm2_publisher" {
  description = "VM Publisher"
  default     = ""
}
variable "vm3_publisher" {
  description = "VM Publisher"
  default     = ""
}
variable "vm4_publisher" {
  description = "VM Publisher"
  default     = ""
}
variable "vm1_offer" {
  description = "VM Offer"
  default     = ""
}
variable "vm2_offer" {
  description = "VM Offer"
  default     = ""
}
variable "vm3_offer" {
  description = "VM Offer"
  default     = ""
}
variable "vm4_offer" {
  description = "VM Offer"
  default     = ""
}
variable "vm1_sku" {
  description = "VM SKU"
  default     = ""
}
variable "vm2_sku" {
  description = "VM SKU"
  default     = ""
}
variable "vm3_sku" {
  description = "VM SKU"
  default     = ""
}
variable "vm4_sku" {
  description = "VM SKU"
  default     = ""
}
variable "vm1_version" {
  description = "VM Version"
  default     = ""
}
variable "vm2_version" {
  description = "VM Version"
  default     = ""
}
variable "vm3_version" {
  description = "VM Version"
  default     = ""
}
variable "vm4_version" {
  description = "VM Version"
  default     = ""
}