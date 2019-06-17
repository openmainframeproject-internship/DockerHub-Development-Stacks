FROM vedarth/sles

RUN zypper update -y && \
    zypper install -y redis

EXPOSE      6379

CMD 		[ "redis-server" ]