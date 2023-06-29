#!/bin/bash

# Update the package lists
sudo yum update

# Install Apache
sudo yum install -y httpd

# Enable Apache to start on boot
sudo systemctl enable httpd

# Start Apache
sudo systemctl start httpd

# Install MySQL and secure the installation
sudo yum install -y mysql-server


# Install PHP and required extensions
sudo yum install -y php

# Restart Apache
sudo systemctl restart apache2

# Create a PHP info file
echo "<?php phpinfo(); ?>" | sudo tee /var/www/html/phpinfo.php

echo "LAMP stack installation completed successfully!"
