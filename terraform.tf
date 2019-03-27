provider "azurerm" {
    subscription_id = "${var.subscription_id}"
    client_id       = "${var.client_id}"
    client_secret   = "${var.client_secret}"
    tenant_id       = "${var.tenant_id}"
}

resource "azurerm_resource_group" "myterraformgroup" {
    name     = "Amik-ResourceGroup"
    location = "West US"

    tags {
        environment = "Demo"
    }
}

