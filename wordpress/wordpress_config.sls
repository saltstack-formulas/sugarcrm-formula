{% from "wordpress/map.jinja" import map with context %}

{% set username = salt['pillar.get']('wordpress:wp-username') %}
{% set database = salt['pillar.get']('wordpress:wp-database') %}
{% set password = salt['pillar.get']('wordpress:wp-passwords:wordpress') %}

include: 
  - wordpress

wordpress-config:
  file.managed:
    - name: {{ map.docroot }}/wp-config.php
    - source: salt://mysql/files/wp-config.php
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
