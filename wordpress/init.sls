{% from "wordpress/map.jinja" import map with context %}

include:
  - wordpress.cli
 

{% for site in pillar['wordpress']['sites'] %}
{{ map.docroot }}/{{ site }}:
  file.directory:
    - user: {{ map.www_user }}
    - group: {{ map.www_group }}
    - mode: 755
    - makedirs: True

# This command tells wp-cli to install wordpress
install_wordpress:
 cmd.run:
  - cwd: {{ map.docroot }}/{{ site }}
  - name: '/usr/local/bin/wp core install --url={{ site.url }} --title={{ site.url }} --admin_user={{ site.user }} --admin_password={{ site.password }} --admin_email={{ site.email }} --path={{ map.docroot }}/{{ site }}'
  - user: {{ map.www_user }}
  - unless: test -d {{ map.docroot }}/{{ site }}/wp-config.php

# This command tells wp-cli to create our wp-config.php, DB info needs to be the same as above
config_wordpress:
 cmd.run:
  - name: '/usr/local/bin/wp core config --dbname={{ site.database }} --dbuser={{ site.dbuser }} --dbpass={{ site.dbpass }} --path={{ map.docroot }}/{{ site }}'
  - cwd: {{ map.docroot }}/{{ site }}
  - user: www-data

{% endfor %}
