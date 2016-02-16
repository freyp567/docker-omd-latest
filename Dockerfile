FROM ubuntu:latest
MAINTAINER Peter Frey<freyp567@googlemail.com>
EXPOSE 80 22 4730 5666

ENV REFRESHED 2016-02-16
ENV DEBIAN_FRONTEND noninteractive

RUN  echo 'net.ipv6.conf.default.disable_ipv6 = 1' > /etc/sysctl.d/20-ipv6-disable.conf; \ 
    echo 'net.ipv6.conf.all.disable_ipv6 = 1' >> /etc/sysctl.d/20-ipv6-disable.conf; \ 
    echo 'net.ipv6.conf.lo.disable_ipv6 = 1' >> /etc/sysctl.d/20-ipv6-disable.conf; \ 
    cat /etc/sysctl.d/20-ipv6-disable.conf; sysctl -p

RUN gpg --keyserver keys.gnupg.net --recv-keys F8C1CA08A57B9ED7 && \
    gpg --armor --export F8C1CA08A57B9ED7 | apt-key add - && \
    echo "deb http://labs.consol.de/repo/testing/ubuntu $(lsb_release -sc) main" >> /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y lsof vim git openssh-server tree tcpdump libevent-2.0-5

RUN apt-get install -y xinetd  omd-labs-edition-daily 
RUN a2enmod proxy_http

ENV OMDSITE cmkfrp
#TODO replace demo by $OMDSITE below

RUN sed -i 's|echo "on"$|echo "off"|' /opt/omd/versions/default/lib/omd/hooks/TMPFS
RUN omd create demo || true
RUN omd config demo set APACHE_TCP_ADDR 0.0.0.0
RUN omd config demo set APACHE_MODE own
RUN omd config demo set DEFAULT_GUI check_mk
RUN echo 'demo:ama1thea' | chpasswd

ENV OMD_DEMO /opt/omd/sites/demo

ADD run_omd.sh /run_omd.sh
CMD ["/run_omd.sh"]
