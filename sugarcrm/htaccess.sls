{% from "sugarcrm/map.jinja" import map with context %}

include: 
  - sugarcrm

sugarcrm-htaccess:
  file.managed:
    - name: {{ map.docroot }}/.htaccess
    - source: 
      - salt://sugarcrm/files/htaccess.{{ grains['fqdn'] }}
      - salt://sugarcrm/files/htaccess
    - mode: 0644
    - user: {{ map.www_user }}
    - group: {{ map.www_group }}