FROM ubuntu:18.04
LABEL maintainer="fjzeng@outlook.com"

RUN apt-get update
RUN apt-get install -y git curl gnupg2 apt-utils mysql-server
RUN curl -sL https://deb.nodesource.com/setup_11.x | bash -
RUN apt-get install -y nodejs

WORKDIR /root
Add database.sql .
RUN /etc/init.d/mysql start && mysql -u root < database.sql
EXPOSE 3306

RUN git clone --branch master https://github.com/ether/etherpad-lite.git
WORKDIR /root/etherpad
Add settings.json .
EXPOSE 9001

RUN export NODE_ENV=production
CMD /etc/init.d/mysql start
CMD bin/run.sh
