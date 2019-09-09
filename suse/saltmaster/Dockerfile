FROM	vedarth/sles

RUN zypper update -y
RUN zypper install -y salt-master  

# Volumes
VOLUME 		["/etc/salt/pki", "/var/cache/salt", "/var/logs/salt", "/etc/salt/master.d", "/srv/salt"]

# Add Run File
ADD 		run.sh /usr/local/bin/run.sh
RUN 		chmod +x /usr/local/bin/run.sh

# Ports
EXPOSE 		4505 4506

# Run Command
CMD 		"/usr/local/bin/run.sh"
