FROM vedarth/sles

RUN zypper install -y go1.10 git

COPY 		go-wrapper /usr/local/bin/

RUN		chmod +x /usr/local/bin/go-wrapper