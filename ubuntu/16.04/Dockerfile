FROM ubuntu:xenial

ENV INITRD=No \
    debian_frontend=noninteractive \
    LC_ALL=C.UTF-8 \
    unicode=YES

RUN cd && set -ex && \
  echo 'Acquire::http {No-Cache=True;};' | tee /etc/apt/apt.conf.d/no-http-cache && \
  dpkg-divert --local --rename --add /usr/bin/ischroot && \
    ln -sf /bin/true /usr/bin/ischroot && \
  apt-get update && \
  apt-get install -y --no-install-recommends apt-transport-https ca-certificates && \
  apt-get dist-upgrade -y --no-install-recommends -o Dpkg::Options::="--force-confold" && \
  apt-get install -y --no-install-recommends wget && \
  wget --https-only --no-cache --no-hsts --no-verbose https://github.com/krallin/tini/releases/download/v0.17.0/tini_0.17.0-amd64.deb && \
  wget --https-only --no-cache --no-hsts --no-verbose https://github.com/krallin/tini/releases/download/v0.17.0/tini_0.17.0-amd64.deb.asc && \
  gpg --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 595E85A6B1B4779EA4DAAEC70B588DFF0527A9B7 && \
  gpg --verify tini_0.17.0-amd64.deb.asc && \
  dpkg -i tini_0.17.0-amd64.deb && \
  rm -f -- tini_0.17.0-amd64.deb.asc tini_0.17.0-amd64.deb && \
  apt-get purge -y wget apt-transport-https ca-certificates && \
  apt-get autoremove -y && \
  apt-get clean && \
  rm -rf -- /tmp/* /var/tmp/* \
     /var/cache/apt/* /var/lib/apt/lists/* \
     /root/.gnupg

ENTRYPOINT ["/usr/bin/tini", "-g", "--"]
