FROM vedarth/sles

EXPOSE 80 443 3000 35729 8080

WORKDIR		/home/mean

# Install gem sass for  grunt-contrib-sass
RUN 		zypper install -y "*v8*5.2.258-11*" mongodb-enterprise \
				mongodb-enterprise-server mongodb-enterprise-tools mongodb-enterprise-shell \
				ruby ruby-devel perl-Digest-SHA git \
				make gcc gcc-c++ krb5-devel phantomjs && \
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
