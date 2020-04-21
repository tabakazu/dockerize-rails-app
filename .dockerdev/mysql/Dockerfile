FROM mysql:8.0

ENV LANG ja_JP.utf8

ADD ./.dockerdev/mysql/conf.d/default_authentication.cnf /etc/mysql/conf.d/.

CMD ["mysqld"]
