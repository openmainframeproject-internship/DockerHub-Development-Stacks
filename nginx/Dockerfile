FROM vedarth/sles

RUN zypper install -y nginx

VOLUME ["/etc/nginx/certs", "/etc/nginx/conf.d", "/var/log/nginx"]

WORKDIR 	/etc/nginx

CMD 		["nginx","-g","daemon off;"]

EXPOSE 		80 443