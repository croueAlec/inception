FROM debian:bullseye

# Install MariaDB
RUN apt update && apt upgrade -y && apt install -y mariadb-server
RUN apt clean

# Setup Config
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY mariadb_start.sh /
RUN chmod +x /mariadb_start.sh

EXPOSE 3306

CMD [ "/mariadb_start.sh" ]