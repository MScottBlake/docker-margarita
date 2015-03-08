FROM python:2.7-slim

MAINTAINER Scott Blake "Scott.Blake@mail.wvu.edu"

RUN apt-get update \
  && apt-get install -y curl \
  && apt-get clean \
  && pip install flask \
  && mkdir -p /margarita \
  && curl -ksSL https://github.com/jessepeterson/margarita/tarball/master | tar zx \
  && cp -rf jessepeterson-margarita-*/* /margarita \
  && rm -f master \
  && curl -ksSL https://github.com/wdas/reposado/tarball/master | tar zx \
  && cp -rf wdas-reposado-*/code/reposadolib /margarita \
  && rm -f master \
  && rm -rf jessepeterson-margarita-* wdas-reposado-* \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY preferences.plist /margarita/preferences.plist

ENTRYPOINT ["python", "/margarita/margarita.py"]
