{% from "sugarcrm/map.jinja" import map with context %}

include:
  - sugarcrm.cli

download_sugarcrm:
 cmd.run:
  - name: 'wget -O  {{ map.tmp_dir }}/sugarcrm.zip {{ salt['pillar.get']('sugarcrm:source') }}'
  - user: {{ map.www_user }}

{% for id, site in salt['pillar.get']('sugarcrm:sites', {}).items() %}
{{ map.docroot }}/{{ id }}:
  file.directory:
    - user: {{ map.www_user }}
    - group: {{ map.www_group }}
    - mode: 755
    - makedirs: True

{% if site.get('source') %}
/tmp/sugarcrm_{{ id }}.zip:
  file.managed:
    - source: {{ site.get('source') }}
    - source_hash: {{ site.get('source_hash') }}
    - user: {{ map.www_user }}
    - group: {{ map.www_group }}
    - mode: 640
{% endif %}   

{{ map.docroot }}/{{ id }}/config_si.php:
  file.managed:
    - source: salt://sugarcrm/files/config_si.php
    - user: {{ map.www_user}}
    - group: {{ map.www_group }}
    - mode: 640
    - template: jinja
    - defaults:
        dbuser: "{{ site.get('dbuser') }}"
        dbpass: "{{ site.get('dbpass') }}"
        database: "{{ site.get('database') }}"
        dbhost: "{{ site.get('dbhost') }}"        
        url: "{{ site.get('url') }}"
        username: "{{ site.get('username') }}"
        password: "{{ site.get('password') }}"
        license: "{{ site.get('license', '') }}"
        title: "{{ site.get('title', '') }}"

# This command tells sugarcli to install sugarcrm
install_{{ id }}:
 cmd.run:
  - cwd: {{ map.docroot }}/{{ id }}
{% if site.get('source') %}  
  - name: '/usr/local/bin/sugarcli install:run -p {{ map.docroot }}/{{ id }} -u {{ site.get('url') }} -s {{ map.tmp_dir }}/sugarcrm_{{ id }}.zip -c {{ map.docroot }}/{{ id }}/config_si.php'
{% else %}  
  - name: '/usr/local/bin/sugarcli install:run -p {{ map.docroot }}/{{ id }} -u {{ site.get('url') }} -s {{ map.tmp_dir }}/sugarcrm.zip -c {{ map.docroot }}/{{ id }}/config_si.php'
{% endif %}   
  - user: {{ map.www_user }}
  - unless: test -d {{ map.docroot }}/{{ id }}/config_si.php  

# This command tells sugarcli to check our config_si.php
check_{{ id }}:
 cmd.run:
  - name: '/usr/local/bin/sugarcli install:check -p {{ map.docroot }}/{{ id }}'
  - cwd: {{ map.docroot }}/{{ id }}
  - user: {{ map.www_user }}

{% endfor %}
