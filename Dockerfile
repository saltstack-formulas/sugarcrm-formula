FROM opw-salt
MAINTAINER Fintan MacMahon <fintan.macmahon@gmail.com>

# ENV http_proxy="http://webproxy1.i.opw.ie:3128" 
# ENV https_proxy="http://webproxy1.i.opw.ie:3128" 

RUN echo deb http://ppa.launchpad.net/saltstack/salt/ubuntu trusty main | tee /etc/apt/sources.list.d/saltstack.list && \
    wget -q -O- "http://keyserver.ubuntu.com/pks/lookup?op=get&search=0x4759FA960E27C0A6" | apt-key add -
RUN apt-get update && apt-get install -y salt-master salt-minion
RUN apt-get install php5-fpm -y
ADD wordpress /srv/salt/wordpress
ADD pillar.example /srv/pillar/example.sls
RUN mkdir -p /etc/salt/minion.d
RUN echo "file_client: local" > /etc/salt/minion.d/local.conf
RUN echo "base:" > /srv/pillar/top.sls
RUN echo " '*':" >> /srv/pillar/top.sls
RUN echo " - example" >> /srv/pillar/top.sls
RUN wget -O /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chown www-data:www-data /usr/local/bin/wp
RUN salt-call --local state.sls wordpress
RUN ls /www/html/sitenameA.com
