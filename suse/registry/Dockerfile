FROM vedarth/sles

RUN zypper update -y && \
  zypper install -y docker-distribution-registry redis

VOLUME 		["/var/lib/registry"]
EXPOSE 		5000
ENTRYPOINT 	["registry"]
CMD 		["serve", "/etc/docker-distribution/registry/config.yml"]
