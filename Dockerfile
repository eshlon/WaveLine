FROM ubuntu:20.04
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get upgrade -y && apt-get -y install  \
    python3 python3-dev python3-pip python3-venv python3-wheel\
    mysql-client libsqlclient-dev libssl-dev default-libmysqlclient-dev

ARG USER=root
USER $USER
RUN python3 -m venv venv
RUN source venv/bin/activate
COPY requirements.txt /app/requirements.txt
WORKDIR /app
RUN python -m pip install requirements.txt

COPY . .
EXPOSE 8000
RUN chmod +x /app/start.sh
ENTRYPOINT ["./start.sh"]
