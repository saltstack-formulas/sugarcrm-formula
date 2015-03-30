{% from "wordpress/map.jinja" import map with context %}

include:
  - apache
  - mysql.server
 
wordpress-packages:
  pkg:
    - installed
    - pkgs: {{ map.pkgs|json }}

docroot-dir:
  file.directory:
    - name: {{ map.docroot }}
    - user: {{ map.www_user }}
    - group: {{ map.www_group }}
    - mode: 755
    - makedirs: True

get-wordpress:
  cmd.run:
    - name: 'curl -O https://wordpress.org/latest.tar.gz && tar xvzf latest.tar.gz && /bin/rm latest.tar.gz && mv wordpress {{ map.wordpress_dir }}'
    - cwd: {{ map.docroot }}
    - unless: test -d {{ map.docroot }}/{{ map.wordpress_dir }}
