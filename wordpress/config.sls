{% from "wordpress/map.jinja" import map with context %}
{% for site in pillar['wordpress']['sites'] %}

# This command tells wp-cli to create our wp-config.php, DB info needs to be the same as above
config_wordpress:
 cmd.run:
  - name: '/usr/local/bin/wp core config --dbname={{ site.database }} --dbuser={{ site.dbuser }} --dbpass={{ site.dbpass }}'
  - cwd: {{ map.docroot }}/{{ site }}
  - user: www-data

{% endfor %}