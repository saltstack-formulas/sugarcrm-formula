{% from "wordpress/map.jinja" import map with context %}

include:
  - apache
  - mysql.server
 
wordpress-packages:
  pkg:
    - installed
    - pkgs: {{ map.pkgs|json }}

get-wordpress:
  cmd.run:
    - name: 'curl -O http://wordpress.org/latest.tar.gz && tar xvzf latest.tar.gz && /bin/rm latest.tar.gz'
    - cwd: /var/www/html/
    - unless: test -d /var/www/html/wordpress
