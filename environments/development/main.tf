terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.3.0" # install the latest terraform core if we use version > 4.0
    }
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-${var.environment}"
  location = var.location
}

module "aks" {
  source              = "../../modules/aks"
  cluster_name        = "aks-${var.environment}"
  node_count          = var.node_count
  environment         = var.environment
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  dns_prefix          = "${var.environment}-aks"
  # depends_on          = [azurerm_resource_group.rg]
  # dns_prefix_private_cluster
}

module "networking" {
  source              = "../../modules/networking"
  vnet_name           = "vnet-${var.environment}"
  subnet_name         = "subnet-${var.environment}"
  resource_group_name = azurerm_resource_group.rg.name
  environment         = var.environment
  location            = azurerm_resource_group.rg.location
  # depends_on          = [azurerm_resource_group.rg]
}

# Generate a random suffix for the storage account name
resource "random_string" "storage_suffix" {
  length  = 6
  special = false
  upper   = false
}

module "storage" {
  source               = "../../modules/storage"
  storage_account_name = "sa${var.environment}${random_string.storage_suffix.result}"
  resource_group_name  = azurerm_resource_group.rg.name
  environment          = var.environment
  location             = azurerm_resource_group.rg.location
  # depends_on           = [azurerm_resource_group.rg]
}
