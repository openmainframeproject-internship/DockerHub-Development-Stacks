FROM vedarth/sles

RUN zypper install -y httpd php php7 tar \
    php7-mysql php7-gd openssl psmisc curl

RUN 	curl -LO http://wordpress.org/latest.tar.gz                         &&	\
        mkdir /srv/www/html                                                 &&	\
		tar xvzf /latest.tar.gz -C /srv/www/html --strip-components=1       &&	\
		rm /latest.tar.gz                                                   &&	\
		chown -R apache:apache /srv/www/                                    &&	\
		chmod 755 /scripts/*

EXPOSE 		80

CMD 		["/bin/bash", "/scripts/start.sh"]