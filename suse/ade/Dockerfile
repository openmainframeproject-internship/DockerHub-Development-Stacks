FROM vedarth/sles

RUN zypper update -y && \
  zypper install -y mariadb

RUN zypper ar -f --no-check --no-gpgcheck https://download.sinenomine.net/clefos/epel7/ epel

RUN zypper install -y ade supervisor openssh rsyslog

COPY 	./install.sh /tmp/install.sh

RUN 	/bin/sh /tmp/install.sh

RUN 	rm -rf /tmp/install.sh

COPY		./cfg_files/etc	/etc
COPY		./cfg_files/opt	/opt
COPY		./cfg_files/docker-entrypoint.sh /

RUN chmod +x /etc/init.d/sshd && \
    mkdir -p /var/log/supervisor /var/local/ade && \
    chown -R ade:ade /home/ade/.ssh /opt/ade/conf /var/local/ade

EXPOSE	22

VOLUME 	/var/local/ade

ENTRYPOINT	["/docker-entrypoint.sh"]

CMD 		["supervisord"]
