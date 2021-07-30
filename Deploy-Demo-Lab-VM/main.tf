# Create Resource Group A
resource "azurerm_resource_group" "rg_a" {
  name     = "${var.prefix}-${var.rg_a_name}-${var.region_a}"
  location = var.region_a
  tags = {
    Environment = var.tag_environment
    CreatedBy   = var.tag_createdby
    CreatedWith = var.tag_createdwith
    Project     = var.tag_project
  }

}

# Create Resource Group B
resource "azurerm_resource_group" "rg_b" {
  name     = "${var.prefix}-${var.rg_b_name}-${var.region_b}"
  location = var.region_b
  tags = {
    Environment = var.tag_environment
    CreatedBy   = var.tag_createdby
    CreatedWith = var.tag_createdwith
    Project     = var.tag_project
  }

}

# Create Resource Group C
resource "azurerm_resource_group" "rg_c" {
  name     = "${var.prefix}-${var.rg_c_name}-${var.region_a}"
  location = var.region_a
  tags = {
    Environment = var.tag_environment
    CreatedBy   = var.tag_createdby
    CreatedWith = var.tag_createdwith
    Project     = var.tag_project
  }

}