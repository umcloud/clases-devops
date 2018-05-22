

FROM alpine

MAINTAINER UMCloud <cloud@um.edu.ar>

ENV TERM xterm


RUN apk update
RUN apk add python py2-pip uwsgi uwsgi-python
RUN pip install --upgrade pip
RUN mkdir -p /opt/umcloud/ip-whois
WORKDIR /opt/umcloud/ip-whois
COPY src/* /opt/umcloud/ip-whois/
RUN pip install -r requirements.txt

RUN addgroup -g 1000 -S umcloud && adduser -u 1000 -S umcloud -G umcloud
RUN chown -R umcloud:umcloud /opt/*
USER umcloud
CMD uwsgi --ini /opt/umcloud/ip-whois/app.ini

EXPOSE 8000
