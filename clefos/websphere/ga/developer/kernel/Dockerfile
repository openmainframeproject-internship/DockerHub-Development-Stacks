# (C) Copyright IBM Corporation 2015.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

FROM 		clefos/ibmjava

MAINTAINER 	David Currie <david_currie@uk.ibm.com> (@davidcurrie)

RUN		yum upgrade -y --setopt=tsflags=nodocs && \
		yum install -y --setopt=tsflags=nodocs wget unzip openssl && \
		yum clean all && \
		rm -rf /var/cache/yum/* /tmp/* /var/log/yum.log

# Install WebSphere Liberty
ARG 		LIBERTY_VERSION
ARG 		LIBERTY_URL
ARG 		DOWNLOAD_OPTIONS=""

RUN 		LIBERTY_URL=${LIBERTY_URL:-$(wget -q -O - https://public.dhe.ibm.com/ibmdl/export/pub/software/websphere/wasdev/downloads/wlp/index.yml  | grep $LIBERTY_VERSION -A 6 | sed -n 's/\s*kernel:\s//p' | tr -d '\r' )} \
		    && wget $DOWNLOAD_OPTIONS $LIBERTY_URL -U UA-IBM-WebSphere-Liberty-Docker -O /tmp/wlp.zip \
		    && unzip -q /tmp/wlp.zip -d /opt/ibm \
		    && rm -f /tmp/wlp.zip

ENV 		PATH=/opt/ibm/java/bin:/opt/ibm/wlp/bin:$PATH JAVA_HOME=/opt/ibm/java

# Set Path Shortcuts
ENV 		LOG_DIR=/logs \
    		WLP_OUTPUT_DIR=/opt/ibm/wlp/output

RUN 		mkdir -p /logs \
		    && ln -s $WLP_OUTPUT_DIR/defaultServer /output \
		    && ln -s /opt/ibm/wlp/usr/servers/defaultServer /config

# Configure WebSphere Liberty
RUN 		/opt/ibm/wlp/bin/server create \
		    && rm -rf $WLP_OUTPUT_DIR/.classCache /output/workarea

COPY 		docker-server /opt/ibm/docker/

EXPOSE 		9080 9443

CMD 		["/opt/ibm/docker/docker-server", "run", "defaultServer"]
