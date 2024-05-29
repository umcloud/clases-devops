FROM alpine:3.7

LABEL mantainer="cloud@um.edu.ar"

ENV TERM xterm

RUN apk update
RUN apk add python py2-pip uwsgi uwsgi-python ca-certificates

RUN mkdir /opt
RUN mkdir /opt/validate-email

WORKDIR /opt/validate-email
COPY src/ /opt/validate-email

RUN pip install --trusted-host pypi.python.org --upgrade pip
RUN pip install --trusted-host pypi.python.org -r requirements.txt

USER 1000:1000

CMD uwsgi --ini /opt/validate-email/validate-email.ini

EXPOSE 5000
