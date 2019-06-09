FROM vedarth/sles

RUN zypper install -y httpd php php7 tar \
    php7-mysql php7-gd openssl psmisc curl

RUN 	curl -LO http://wordpress.org/latest.tar.gz                         &&	\
		tar xvzf /latest.tar.gz -C /var/www/html --strip-components=1       &&	\
		rm /latest.tar.gz                                                   &&	\
		chown -R apache:apache /var/www/                                    &&	\
		chmod 755 /scripts/*

EXPOSE 		80

CMD 		["/bin/bash", "/scripts/start.sh"]