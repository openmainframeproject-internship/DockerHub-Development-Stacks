FROM vedarth/sles

RUN zypper update -y && \
  zypper install -y htop git wget tar gzip python-sphinx && \
  cd /opt && \
  wget -q https://github.com/sbt/sbt/releases/download/v1.1.1/sbt-1.1.1.tgz && \
  tar -xzf sbt-1.1.1.tgz && \
  rm -f sbt-1.1.1.tgz && \
  mkdir -p /var/akka/source

WORKDIR	/var/akka/source

VOLUME	["/var/akka/source"]

ENTRYPOINT ["/bin/bash"]
