#!/bin/bash
sudo yum install firewalld -y
sudo systemctl enable firewalld
sudo systemctl start firewalld
sudo yum install httpd -y
sudo mv /tmp/httpd.conf /etc/httpd/conf/httpd.conf
sudo systemctl start httpd
sudo touch /var/www/html/index.html
hostname | sudo tee /var/www/html/index.html
sudo firewall-cmd --zone=public --permanent --add-port=80/tcp
sudo firewall-cmd --reload
