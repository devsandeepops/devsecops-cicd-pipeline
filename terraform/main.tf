resource "azurerm_resource_group" "pipeline_demo" {
  name     = "rg-pipeline-security-demo"
  location = "East US"

  tags = {
    Project     = "devsecops-pipeline-demo"
    Environment = "demo"
  }
}

resource "azurerm_virtual_network" "pipeline_demo" {
  name                = "vnet-pipeline-security-demo"
  location            = azurerm_resource_group.pipeline_demo.location
  resource_group_name = azurerm_resource_group.pipeline_demo.name
  address_space       = ["10.30.0.0/16"]

  tags = azurerm_resource_group.pipeline_demo.tags
}

resource "azurerm_subnet" "pipeline_demo" {
  name                 = "snet-demo"
  resource_group_name  = azurerm_resource_group.pipeline_demo.name
  virtual_network_name = azurerm_virtual_network.pipeline_demo.name
  address_prefixes     = ["10.30.1.0/24"]
}

resource "azurerm_network_security_group" "pipeline_demo" {
  name                = "nsg-pipeline-security-demo"
  location            = azurerm_resource_group.pipeline_demo.location
  resource_group_name = azurerm_resource_group.pipeline_demo.name

  tags = azurerm_resource_group.pipeline_demo.tags
}

resource "azurerm_subnet_network_security_group_association" "pipeline_demo" {
  subnet_id                 = azurerm_subnet.pipeline_demo.id
  network_security_group_id = azurerm_network_security_group.pipeline_demo.id
}