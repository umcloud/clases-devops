

FROM alpine

MAINTAINER UMCloud <cloud@um.edu.ar>

ENV TERM xterm


RUN apk update
RUN apk add python py2-pip uwsgi uwsgi-python
RUN pip install --upgrade pip
RUN mkdir -p /opt/umcloud/ip-mac

WORKDIR /opt/umcloud/ip-mac


COPY src/* /opt/umcloud/ip-mac/
RUN pip install -r requirements.txt
CMD uwsgi --ini /opt/umcloud/ip-mac/app.ini

EXPOSE 8000
