FROM vedarth/sles

EXPOSE 80 443 3000 35729 8080

WORKDIR		/home/mean

RUN zypper addrepo -G --check --refresh "https://repo.mongodb.org/zypper/suse/12/mongodb-org/4.0/s390x/" mongodb

# Install gem sass for  grunt-contrib-sass
RUN 		   zypper install -y libopenssl-1_1-devel libopenssl-devel libopenssl1_1 libopenssl1_1-hmac libcryptopp-devel libcryptopp5_6_5
RUN            zypper install -y    mongodb-org-server mongodb-org-mongos mongodb-org-shell \
                libcryptopp-devel libcryptopp5_6_5 \
				ruby ruby-devel git \
				make gcc gcc-c++ krb5-devel && \
		npm config set registry http://registry.npmjs.org/ && \
		gem install sass && \
		npm install -g grunt-cli && \
		npm install -g bower

# Install Mean.JS packages
ADD		package.json /home/mean/package.json
RUN		npm install

# Manually trigger bower. Why doesnt this work via npm install?
ADD		.bowerrc /home/mean/.bowerrc
ADD		bower.json /home/mean/bower.json

RUN		bower install --config.interactive=false --allow-root=true

RUN	 	rm -rf /var/cache/zypp/* /tmp/* /var/log/zypp.log

# Make everything available for start
ADD		. /home/mean

# Set development environment as default
ENV 	NODE_ENV development

# Port 3000 for server
# Port 35729 for livereload
EXPOSE 	3000 35729

CMD 	["grunt"]
