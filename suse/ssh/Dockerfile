FROM vedarth/sles

RUN zypper ar -f --no-check --no-gpgcheck https://download.sinenomine.net/clefos/epel7/ epel

RUN zypper update -y 

RUN zypper install -y openssh

ADD 		./start.sh /start.sh
RUN 		mkdir /var/run/sshd

RUN 		ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N '' 

RUN 		chmod 755 /start.sh && \
		./start.sh

ENTRYPOINT 	["/usr/sbin/sshd", "-D"]
