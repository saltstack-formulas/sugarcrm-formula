{% from "wordpress/map.jinja" import map with context %}

# This downloads and installs WP-Cli
/usr/local/bin/wp:
  file.managed:
    - source: https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    - source_hash: https://github.com/wp-cli/builds/blob/gh-pages/phar/wp-cli-nightly.phar.md5
    - user: {{ map.www_user }}
    - group: {{ map.www_group }}
    - mode: 766