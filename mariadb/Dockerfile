FROM vedarth/sles

RUN zypper update -y && \
    zypper install -y mariadb bind-utils pwgen

COPY 		fix-permissions.sh ./

COPY 		docker-entrypoint.sh /

COPY		allow-skip-name.cnf /etc/my.cnf.d/

ENTRYPOINT 	["/docker-entrypoint.sh"]

VOLUME 		[/var/lib/mysql]

USER 		27

EXPOSE 		3306
