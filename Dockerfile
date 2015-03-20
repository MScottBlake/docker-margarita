FROM python:2.7-slim

MAINTAINER Scott Blake "Scott.Blake@mail.wvu.edu"

EXPOSE 8089

RUN apt-get update \
  && apt-get install -y apache2 curl libapache2-mod-wsgi \
  && pip install flask \
  && mkdir -p /margarita /var/lock/apache2 /var/run/apache2 \
  && curl -ksSL https://github.com/jessepeterson/margarita/tarball/master | tar zx \
  && cp -rf jessepeterson-margarita-*/* /margarita \
  && rm -f master \
  && curl -ksSL https://github.com/wdas/reposado/tarball/master | tar zx \
  && cp -rf wdas-reposado-*/code/reposadolib /margarita \
  && rm -f master /etc/apache2/sites-enabled/000-default.conf \
  && rm -rf jessepeterson-margarita-* wdas-reposado-* \
  && apt-get -y remove --purge curl \
  && apt-get -y autoremove --purge \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY margarita.conf /etc/apache2/sites-enabled/
COPY margarita.wsgi /margarita/
COPY preferences.plist /margarita/

RUN chgrp -R www-data /margarita \
  && chmod -R g+wr /margarita

CMD ["/usr/sbin/apache2ctl", "-DFOREGROUND"]
