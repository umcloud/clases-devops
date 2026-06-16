FROM alpine

LABEL mantainer="dnavarro@summ.it.com.ar"

ENV TERM=xterm

RUN apk update
RUN apk add python3 uwsgi uwsgi-python py3-pip

RUN mkdir /opt/app

WORKDIR /opt/app
COPY src/ /opt/app

RUN pip3 install --upgrade pip  --break-system-packages
RUN pip3 install -r requirements.txt --break-system-packages

#USER 1000:1000

CMD uwsgi --ini /opt/app/app.ini

EXPOSE 5000
