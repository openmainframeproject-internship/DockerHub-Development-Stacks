FROM vedarth/sles

RUN		zypper update -y && \
  zypper install -y curl git wget tar gcc which gzip

COPY 	./install.sh /tmp/install.sh

RUN 	/bin/sh /tmp/install.sh

RUN 	rm -rf /tmp/install.sh

RUN     echo 'hosts: files mdns4_minimal [NOTFOUND=return] dns mdns4' >> /etc/nsswitch.conf

EXPOSE  2379 2380

# Define default command.
CMD     ["/usr/bin/etcd"]
