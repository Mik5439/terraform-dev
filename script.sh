#!/bin/bash
sudo apt update
sudo apt -y install apache2
sudo systemctl enable apache2
sudo systemctl start apache2
sudo chmod 777 /var/www/html/index.html
sudo echo "$(hostname) $(curl ifconfig.io)" > /var/www/html/index.html
