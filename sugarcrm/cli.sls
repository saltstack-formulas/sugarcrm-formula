{% from "sugarcrm/map.jinja" import map with context %}

# This downloads and installs sugarcli
/usr/local/bin/sugarcli:
  file.managed:
    - source: {{ salt['pillar.get']('sugarcrm:cli:source') }}
    - source_hash: {{ salt['pillar.get']('sugarcrm:cli:hash') }}
    - user: {{ map.www_user }}
    - group: {{ map.www_group }}
    - mode: 740