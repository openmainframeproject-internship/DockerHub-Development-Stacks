#!/bin/bash

mkdir -p /var/local/ade && \
    groupadd ade && \
    useradd -m -c "ADE Administrator" -g ade ade && \
    sed -i 's/#PermitRootLogin yes/PermitRootLogin no/g' /etc/ssh/sshd_config && \
    sed -i 's/PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config && \
    echo "AllowUsers ade" >> /etc/ssh/sshd_config && \
    sed -ri 's/session(\s+)required(\s+)pam_loginuid\.so/#/' /etc/pam.d/sshd && \
    ssh-keygen -A && \
    mkdir -p /home/ade/.ssh && \
    ssh-keygen -q -t dsa -N "" -f /home/ade/.ssh/id_dsa && \
    ssh-keygen -q -t rsa -N "" -f /home/ade/.ssh/id_rsa && \
    mv /home/ade/.ssh/id_rsa.pub /home/ade/.ssh/authorized_keys && \
    echo "******** RSA PrivateKey to use to connect to container ********" && \
    cat /home/ade/.ssh/id_rsa && \
    echo 'export JAVA_HOME=/opt/ibm/java' >>/home/ade/.bashrc && \
    echo 'export JAVA_CLASSPATH=$JAVA_HOME/lib' >>/home/ade/.bashrc && \
    echo 'export PATH=$PATH:/opt/ade/bin:$JAVA_HOME/bin' >>/home/ade/.bashrc && \
