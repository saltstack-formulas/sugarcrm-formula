{% from "sugarcrm/map.jinja" import map with context %}

{% set username = salt['pillar.get']('sugarcrm:wp-username') %}
{% set database = salt['pillar.get']('sugarcrm:wp-database') %}
{% set password = salt['pillar.get']('sugarcrm:wp-passwords:sugarcrm') %}

include: 
  - sugarcrm

sugarcrm-config:
  file.managed:
    - name: {{ map.docroot }}/wp-config.php
    - source: 
      - salt://sugarcrm/files/wp-config.php.{{ grains['fqdn'] }}
      - salt://sugarcrm/files/wp-config.php
    - mode: 0644
    - user: {{ map.www_user }}
    - group: {{ map.www_group }}
    - template: jinja
   # TODO - this steps on get-sugarcrm unless; should require get-sugarcrm and include init?
    - require: 
        - cmd: get-sugarcrm
    - context:
      username: {{ username }}
      database: {{ database }}
      password: {{ password }}

sugarcrm-htaccess:
  file.managed:
    - name: {{ map.docroot }}/.htaccess
    - source: 
      - salt://sugarcrm/files/htaccess.{{ grains['fqdn'] }}
      - salt://sugarcrm/files/htaccess
    - mode: 0644
    - user: {{ map.www_user }}
    - group: {{ map.www_group }}

sugarcrm-keys-file:
  cmd.run:
    - name: /usr/bin/curl -s -o {{ map.docroot }}/wp-keys.php https://api.sugarcrm.org/secret-key/1.1/salt/ && /bin/sed -i "1i\\<?php" {{ map.docroot }}/wp-keys.php && chown -R {{ map.www_user }}:{{ map.www_group }} {{ map.docroot }}
    - unless: test -e {{ map.docroot }}/wp-keys.php
    - require_in:
      - file: sugarcrm-config
