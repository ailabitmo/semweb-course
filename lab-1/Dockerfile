FROM mysql:5.7

ENV MYSQL_DATABASE="simple_library"
ENV MYSQL_ROOT_PASSWORD="111"

ADD simple_library_create.sql /docker-entrypoint-initdb.d
ADD simple_library_fill.sql /docker-entrypoint-initdb.d
ADD charset.cnf /etc/mysql/conf.d

