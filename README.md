# freyp567/docker-omd-latest
open monitoring distribution

adaption of Docker container docker-omd-labs/omd-labs-ubuntu
for experimentation (split service from data + configuration)

run:

  docker run --name omd -p 9080:80 -p 9022:22 -d freyp567/docker-omd-latest

PROBLEM

https://xxxx:9080/demo
SSL-Verbindungsfehler
ERR_SSL_PROTOCOL_ERROR

RUN a2enmod proxy_http
-- does not help here


TODO
+ separate container aspects: 
  - base ubuntu container with small adaptions
  - extended ubuntu container with ssh and some base libs
  - apache container (xinetd)
  - omd container 
 
