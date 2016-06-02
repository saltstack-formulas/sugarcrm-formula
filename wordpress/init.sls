{% from "wordpress/map.jinja" import map with context %}

include:
  - wordpress.cli

{% for id, site in salt['pillar.get']('wordpress:sites', {}).items() %}
{{ map.docroot }}/{{ id }}:
  file.directory:
    - user: {{ map.www_user }}
    - group: {{ map.www_group }}
    - mode: 755
    - makedirs: True

# This command tells wp-cli to install wordpress
install_{{ id }}:
 cmd.run:
  - cwd: {{ map.docroot }}/{{ id }}
  - name: '/usr/local/bin/wp core install --url={{ site.get('url') }} --title={{ site.get('title') }} --admin_user={{ site.get('user') }} --admin_password={{ site.get('password') }} --admin_email={{ site.get('email') }} --path={{ map.docroot }}/{{ id }}'
  - user: root
  - unless: test -d {{ map.docroot }}/{{ id }}/wp-config.php

# This command tells wp-cli to create our wp-config.php, DB info needs to be the same as above
configure_{{ id }}:
 cmd.run:
  - name: '/usr/local/bin/wp core config --dbname={{ site.get('database') }} --dbuser={{ site.get('dbuser') }} --dbpass={{ site.get('dbpass') }} --path={{ map.docroot }}/{{ id }}'
  - cwd: {{ map.docroot }}/{{ id }}
  - user: root

{% endfor %}
