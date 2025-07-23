FROM python:3.9.18-alpine3.19
EXPOSE 8080
WORKDIR /opt/server
COPY code/ .
RUN apk add python3-dev build-base linux-headers pcre-dev
RUN pip3 install -r requirements.txt
RUN apk add python3-dev build-base linux-headers pcre-dev
RUN pip install -r requirements.txt
RUN addgroup -S roboshop && adduser -S roboshop -G roboshop
# RUN addgroup -S <group-name> && adduser -S <user-name> -G <group-name>
RUN chown roboshop:roboshop /opt/server
# chown <user>:<group> <path>
USER roboshop
CMD ["uwsgi", "--ini", "payment.ini"]