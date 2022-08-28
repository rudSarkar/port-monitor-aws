FROM golang:1.19.0-alpine3.16 as builder
WORKDIR /app
RUN go install github.com/rudSarkar/PortMonitor@latest

FROM alpine:latest
RUN apk add --update && apk add python3 && apk add py-pip
WORKDIR /app
COPY --from=builder /go/bin/PortMonitor /bin/PortMonitor
RUN chmod 0777 /bin/PortMonitor
RUN mkdir -p ~/.portmonitor
COPY . .
RUN cp ./.env ~/.portmonitor/
RUN pip3 install -r requirements.txt
RUN mkdir ~/.aws

RUN cp ./aws/config ~/.aws/

RUN chmod 0777 regular_scan.sh
RUN mkdir /etc/cron.d/
RUN cp /app/portscanner.cron /etc/cron.d/
RUN chmod 0644 /etc/cron.d/portscanner.cron

RUN crontab /etc/cron.d/portscanner.cron
RUN touch /var/log/cron.log

CMD ["/usr/sbin/crond", "-f", "-d", "0", "&&", "tail", "-f", "/var/log/cron.log"]