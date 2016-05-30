{% from "nginx/map.jinja" import nginx with context %}

# This downloads and installs WP-Cli
/usr/local/bin/wp:
  file.managed:
    - source: https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    - source_hash: https://github.com/wp-cli/builds/blob/gh-pages/phar/wp-cli-nightly.phar.md5
    - user: {{ wordpress.www_user }}
    - group: {{ wordpress.www_group }}
    - mode: 766
