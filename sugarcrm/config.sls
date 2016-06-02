{% from "sugarcrm/map.jinja" import map with context %}
{% for site in pillar['sugarcrm']['sites'] %}

# This command tells sugarcli.phar to create our config.php, DB info needs to be the same as above
config_sugarcrm:
 cmd.run:
  - name: '/usr/local/bin/sugarcli core config --dbname={{ site.database }} --dbuser={{ site.dbuser }} --dbpass={{ site.dbpass }}'
  - cwd: {{ map.docroot }}/{{ site }}
  - user: www-data

{% endfor %}