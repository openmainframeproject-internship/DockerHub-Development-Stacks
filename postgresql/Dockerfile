FROM vedarth/sles

RUN zypper install -y sudo \
    postgresql postgresql-server postgresql-contrib

ADD 		./postgresql-setup /usr/bin/postgresql-setup
ADD 		./start_postgres.sh /start_postgres.sh

RUN		sed -i 's/.*requiretty$/#Defaults requiretty/' /etc/sudoers && \
		chmod +x /usr/bin/postgresql-setup && \
		chmod +x /start_postgres.sh && \
		/usr/bin/postgresql-setup initdb

ADD 		./postgresql.conf /var/lib/pgsql/data/postgresql.conf

RUN 		chown -v postgres.postgres /var/lib/pgsql/data/postgresql.conf && \
		echo "host    all             all             0.0.0.0/0               md5" >> /var/lib/pgsql/data/pg_hba.conf

VOLUME		["/var/lib/pgsql"]

EXPOSE 		5432

CMD 		["/bin/bash", "/start_postgres.sh"]

