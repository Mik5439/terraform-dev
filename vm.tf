resource "azurerm_virtual_machine" "ubuntu" {
  name                  = "${var.prefix}-vm"
  location              = "West US"
  resource_group_name   = "${azurerm_resource_group.myterraformgroup.name}"
  network_interface_ids = ["${azurerm_network_interface.myterraformnic.id}"]
  vm_size               = "Standard_DS1_v2"
  delete_os_disk_on_termination = true
  delete_data_disks_on_termination = true
  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "websrv"
    admin_username = "${var.username}"
	admin_password = "${var.pass}"
    }
  os_profile_linux_config {
    disable_password_authentication = false
  }
    
  provisioner "file" {
  source      = "script.sh"
  destination = "/tmp/script.sh"
  connection {
    type     = "ssh"
    user     = "${var.username}"
    password = "${var.pass}"
  }
}
	provisioner "remote-exec" {
    inline = [
     "chmod a+x /tmp/script.sh",
     "/tmp/script.sh",
	]
	connection {
	  type  = "ssh"
	  agent = "false"
	  host = "${azurerm_public_ip.myterraformpublicip.ip_address}"
      user     = "${var.username}"
      password = "${var.pass}"
         
    }
}
    tags = {
    environment = "Demo"
  }
}