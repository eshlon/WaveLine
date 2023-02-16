FROM ubuntu:20.04
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get -y install \
    python3.11 python3.11-dev python3.11-pip python3.11-venv python3.11-wheel\
    mysql-client libsqlclient-dev libssl-dev default-libmysqlclient-dev

ARG USER=root
USER $USER
RUN python3.11 -m venv venv
WORKDIR /app
COPY requirements.txt requirements.txt
RUN /venv/bin/pip3 install -r requirements.txt

COPY . .
EXPOSE 8000
RUN chmod +x /app/start.sh
ENTRYPOINT ["./start.sh"]
