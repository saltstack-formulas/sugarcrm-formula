{% from "sugarcrm/map.jinja" import map with context %}

include:
  - sugarcrm.cli

{% for id, site in salt['pillar.get']('sugarcrm:sites', {}).items() %}
{{ map.docroot }}/{{ id }}:
  file.directory:
    - user: {{ map.www_user }}
    - group: {{ map.www_group }}
    - mode: 755
    - makedirs: True

# This command tells sugarcli to download sugarcrm
download_wordpress_{{ id }}:
 cmd.run:
  - cwd: {{ map.docroot }}/{{ id }}
  - name: '/usr/local/bin/sugarcli install:config:get --path="{{ map.docroot }}/{{ id }}/"'
  - user: {{ map.www_user }}
  - unless: test -d {{ map.docroot }}/{{ id }}/config_si.php

# This command tells sugarcli to install sugarcrm
install_{{ id }}:
 cmd.run:
  - cwd: {{ map.docroot }}/{{ id }}
  - name: '/usr/local/bin/sugarcli core install --url="{{ site.get('url') }}" --title="{{ site.get('title') }}" --admin_user="{{ site.get('user') }}" --admin_password="{{ site.get('password') }}" --admin_email="{{ site.get('email') }}" --path="{{ map.docroot }}/{{ id }}/"'
  - user: {{ map.www_user }}
  - unless: test -d {{ map.docroot }}/{{ id }}/config_si.php  

# This command tells sugarcli to create our config_si.php, DB info needs to be the same as above
configure_{{ id }}:
 cmd.run:
  - name: '/usr/local/bin/sugarcli core config --dbname="{{ site.get('database') }}" --dbuser="{{ site.get('dbuser') }}" --dbpass="{{ site.get('dbpass') }}" --path="{{ map.docroot }}/{{ id }}"'
  - cwd: {{ map.docroot }}/{{ id }}
  - user: {{ map.www_user }}

{% endfor %}
