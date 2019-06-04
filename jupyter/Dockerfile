FROM vedarth/sles

RUN    zypper install -y python3-devel gcc libzmq5
RUN    pip3 install jupyter
RUN    pip3 install notebook

WORKDIR /data