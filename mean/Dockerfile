FROM vedarth/sles

EXPOSE 80 443 3000 35729 8080

ENV NODE_ENV development

RUN zypper -n install git
RUN zypper -n install openssh
RUN zypper -n install gcc
RUN zypper -n install make
RUN zypper -n install nodejs6
RUN zypper -n install npm
RUN sed -i -e 's/uidSupport = process.getuid && process.setuid/uidSupport = false/g' /usr/lib64/node_modules/npm10/node_modules/uid-number/uid-number.js
RUN npm install --quiet -g gulp bower yo mocha karma-cli pm2 && npm cache clean
RUN mkdir -p /opt/mean.js/public/lib
WORKDIR /opt/mean.js
RUN git clone https://github.com/meanjs/mean.git
RUN cp -a mean/. .
RUN npm install --quiet && npm cache clean
RUN bower install --quiet --allow-root --config.interactive=false
CMD npm install && npm start

RUN zypper ref -s
RUN zypper -n in vim
