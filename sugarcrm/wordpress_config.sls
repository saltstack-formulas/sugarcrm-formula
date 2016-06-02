{% from "wordpress/map.jinja" import map with context %}

{% set username = salt['pillar.get']('wordpress:wp-username') %}
{% set database = salt['pillar.get']('wordpress:wp-database') %}
{% set password = salt['pillar.get']('wordpress:wp-passwords:wordpress') %}

include: 
  - wordpress

wordpress-config:
  file.managed:
    - name: {{ map.docroot }}/wp-config.php
    - source: 
      - salt://wordpress/files/wp-config.php.{{ grains['fqdn'] }}
      - salt://wordpress/files/wp-config.php
    - mode: 0644
    - user: {{ map.www_user }}
    - group: {{ map.www_group }}
    - template: jinja
   # TODO - this steps on get-wordpress unless; should require get-wordpress and include init?
    - require: 
        - cmd: get-wordpress
    - context:
      username: {{ username }}
      database: {{ database }}
      password: {{ password }}

wordpress-htaccess:
  file.managed:
    - name: {{ map.docroot }}/.htaccess
    - source: 
      - salt://wordpress/files/htaccess.{{ grains['fqdn'] }}
      - salt://wordpress/files/htaccess
    - mode: 0644
    - user: {{ map.www_user }}
    - group: {{ map.www_group }}

wordpress-keys-file:
  cmd.run:
    - name: /usr/bin/curl -s -o {{ map.docroot }}/wp-keys.php https://api.wordpress.org/secret-key/1.1/salt/ && /bin/sed -i "1i\\<?php" {{ map.docroot }}/wp-keys.php && chown -R {{ map.www_user }}:{{ map.www_group }} {{ map.docroot }}
    - unless: test -e {{ map.docroot }}/wp-keys.php
    - require_in:
      - file: wordpress-config
