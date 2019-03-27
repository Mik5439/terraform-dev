resource "azurerm_public_ip" "myterraformpublicip" {
    name                         = "myPublicIP"
    location                     = "West US"
    resource_group_name          = "${azurerm_resource_group.myterraformgroup.name}"
    allocation_method            = "Static"

    tags {
        environment = "Demo"
    }
}

output "public_ip_address" {
  value = "${azurerm_public_ip.myterraformpublicip.ip_address}"
}