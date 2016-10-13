FROM python:2.7-slim

MAINTAINER Scott Blake "Scott.Blake@mail.wvu.edu"

EXPOSE 8089

RUN apt-get update -qq \
  && apt-get install -y -qq apache2 apache2-utils curl libapache2-mod-wsgi \
  && pip install -q flask \
  && mkdir -p /margarita /var/lock/apache2 /var/run/apache2 \
  && curl -ksSL https://github.com/jessepeterson/margarita/tarball/master \
    | tar zx \
  && cp -rf jessepeterson-margarita-*/* /margarita \
  && rm -f master \
  && curl -ksSL https://github.com/wdas/reposado/tarball/master | tar zx \
  && cp -rf wdas-reposado-*/code/reposadolib /margarita \
  && rm -f master /etc/apache2/sites-enabled/000-default.conf \
  && rm -rf jessepeterson-margarita-* wdas-reposado-* \
  && apt-get -y -qq remove --purge curl \
  && apt-get -y -qq autoremove --purge \
  && apt-get -qq clean \
  && a2enmod auth_digest authn_anon authn_dbd authn_dbm authn_socache \
             authnz_fcgi authnz_ldap authz_dbd authz_dbm authz_groupfile \
             authz_owner ssl \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY extras.conf /
COPY margarita.conf /etc/apache2/sites-enabled/
COPY margarita.wsgi /
COPY preferences.plist /margarita/
COPY start.sh /

RUN chgrp -R www-data /margarita \
  && chmod -R g+rs /margarita \
  && chgrp -R www-data /start.sh \
  && chmod g+x /start.sh

CMD ["/start.sh"]
