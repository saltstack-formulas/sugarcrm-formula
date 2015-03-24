{% from "wordpress/map.jinja" import map with context %}

{% set username = salt['pillar.get']('wordpress:wp-username') %}
{% set database = salt['pillar.get']('wordpress:wp-database') %}
{% set password = salt['pillar.get']('wordpress:wp-passwords:wordpress') %}

wordpress-config:
  file.managed:
    - name: {{ map.wordpress_config_name }}
    - source: salt://mysql/files/wp-config.php
    - mode: 0644
    - user: {{ map.www_user }}
    - group: {{ map.www_group }}
    - template: jinja
    - makedirs: True
    - context:
      username: {{ username }}
      database: {{ database }}
      password: {{ password }}
