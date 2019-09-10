FROM	vedarth/sles

RUN zypper update -y

RUN zypper install -y wget tar gzip bzip2 ant

# Create a working directory for Apache Solr
RUN mkdir /Apache_Solr

# Change to working directory 
WORKDIR /Apache_Solr

# Download Apache Solr 6.6.1 source code
WORKDIR /Apache_Solr
RUN wget http://archive.apache.org/dist/lucene/solr/6.6.1/solr-6.6.1-src.tgz
RUN tar -xzf solr-6.6.1-src.tgz

# Build Apache Solr 
WORKDIR /Apache_Solr/solr-6.6.1/solr
RUN ant ivy-bootstrap

# Edit the solr and solr.cmd file 
WORKDIR /Apache_Solr/solr-6.6.1/solr/bin
RUN sed -i 's/Xloggc/Xverbosegclog/g' solr && \
		sed -i 's/JAVA_VERSION:(-2)/JAVA_VERSION:(-1)/g' solr && \
		sed -i 's/Xloggc/Xverbosegclog/g' solr.cmd

# Port for Apache Solr
EXPOSE 8983

# Command to execute
RUN chmod a+x solr

CMD ./solr start && tail -F /Apache_Solr/solr-6.6.1/solr/server/logs/solr.log
