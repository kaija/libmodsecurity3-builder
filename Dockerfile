FROM ubuntu:18.04

RUN apt update && DEBIAN_FRONTEND=noninteractive apt install -y build-essential git libpcre3 libpcre3-dev libssl-dev libtool autoconf libxml2-dev libcurl4-openssl-dev apache2-dev libpcre3-dev libxml2-dev zlib1g-dev libssl-dev libgd-dev libgeoip-dev libxslt1-dev libxml2-dev libhiredis-dev libluajit-5.1-dev libmaxminddb-dev libmhash-dev libpam0g-dev libperl-dev quilt dwz debhelper=11.1.6ubuntu1 dh-systemd software-properties-common libyajl-dev liblua5.1-dev

RUN apt install -y libcurl4-openssl-dev libfuzzy-dev

RUN mkdir -p /opt/modsecurity/build

WORKDIR /opt/modsecurity/build


COPY modsecurity_3.0.4.orig.tar.gz /opt/modsecurity/build

RUN tar zxvf modsecurity_3.0.4.orig.tar.gz && mv modsecurity-v3.0.4 modsecurity

WORKDIR /opt/modsecurity/build

COPY debian /opt/modsecurity/build/modsecurity/debian

#COPY modsecurity_3.0.4.orig.tar.gz /opt/modsecurity/build

#RUN cp -dpR debian /opt/modsecurity/build/modsecurity/debian

#RUN cp -dpR debian ${PACKAGE_NAME}-${PACKAGE_VERSION}/debian

RUN cd modsecurity && ls -al  && dpkg-buildpackage -S -us -uc -jauto
#
RUN cd modsecurity && dpkg-buildpackage -b -us -uc -jauto
