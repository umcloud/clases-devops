FROM alpine

LABEL mantainer="cloud@um.edu.ar"

ENV TERM xterm
ENV APP_KEY default_default


RUN apk update
RUN apk add python py2-pip uwsgi uwsgi-python
RUN pip install --upgrade pip
RUN mkdir -p /opt/umcloud/ip-whois
WORKDIR /opt/umcloud/ip-whois
COPY src/* /opt/umcloud/ip-whois/
RUN pip install -r requirements.txt

USER 1000:1000
CMD uwsgi --ini /opt/umcloud/ip-whois/app.ini

EXPOSE 8000
