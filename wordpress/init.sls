{% from "wordpress/map.jinja" import map with context %}

include:
  - mysql.server
 
wordpress-packages:
  pkg.latest:
    - pkgs: {{ map.pkgs|json }}

get-wordpress:
  cmd.run:
    - name: 'curl -O http://wordpress.org/latest.tar.gz && tar xvzf latest.tar.gz && /bin/rm latest.tar.gz'
    - cwd: /var/www/html/
    - unless: test -d /var/www/html/wordpress
    - require:
      - pkg: httpd-packages
    - require_in:
      - file: /var/www/html/wordpress/wp-config.php
  
wordpress-keys-file:
  cmd.run:
    - name: /usr/bin/curl -s -o /var/www/html/wordpress/wp-keys.php https://api.wordpress.org/secret-key/1.1/salt/ && /bin/sed -i "1i\\<?php" /var/www/html/wordpress/wp-keys.php && chown -R apache:apache /var/www/html/wordpress
    - unless: test -e /var/www/html/wordpress/wp-keys.php
    - require_in:
      - file: /var/www/html/wordpress/wp-config.php
