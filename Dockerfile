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
CMD ["uwsgi", "--ini", "payment.ini"]


# # 84s batch code below 
# # Stage 1: Build
# FROM python:3.9.23-alpine3.22 AS builder
# WORKDIR /build
# # Install build dependencies
# RUN apk add --no-cache python3-dev build-base linux-headers pcre-dev
# COPY code/requirements.txt .
# RUN pip3 install --no-cache-dir --prefix=/install -r requirements.txt


# # Stage 2: Final image
# FROM python:3.9.23-alpine3.22
# EXPOSE 8080
# WORKDIR /opt/server
# # Runtime dependencies only
# RUN apk add --no-cache pcre
# # Create app user
# RUN addgroup -S roboshop && adduser -S roboshop -G roboshop
# USER roboshop
# # Copy installed Python packages from builder
# COPY --from=builder /install /usr/local
# # Copy application code
# COPY --chown=roboshop:roboshop code/payment.ini .
# COPY --chown=roboshop:roboshop code/*.py .
# CMD ["uwsgi", "--ini", "payment.ini"]




