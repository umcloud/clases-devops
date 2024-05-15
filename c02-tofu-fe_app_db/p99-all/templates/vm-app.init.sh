#!/bin/bash

sudo tee /etc/apache2/sites-available/wordpress.conf << EOF
Alias /blog /usr/share/wordpress
<Directory /usr/share/wordpress>
    Options FollowSymLinks
        AllowOverride Limit Options FileInfo
    DirectoryIndex index.php
    Order allow,deny
    Allow from all
</Directory>
<Directory /usr/share/wordpress/wp-content>
    Options FollowSymLinks
    Order allow,deny
    Allow from all
</Directory>
EOF
sudo a2ensite wordpress && sudo a2enmod rewrite
sudo service apache2 restart

tf_ip=$(ip r get 1.1.1.1 | sed -rn 's/.*src (\S+) .*/\1/p')
sudo tee "/etc/wordpress/config-$tf_ip.php" << EOF
<?php
define('DB_NAME', 'wordpress');
define('DB_USER', 'wordpress');
define('DB_PASSWORD', 'telewordpress'); #password DB
define('DB_HOST', '${db_ip}');
define('DB_COLLATE', 'utf8_general_ci');
define('WP_CONTENT_DIR', '/usr/share/wordpress/wp-content');
define( 'WP_HOME', 'http://${fe_fip}/blog' );
define( 'WP_SITEURL', 'http://${fe_fip}/blog' );
?>
EOF

