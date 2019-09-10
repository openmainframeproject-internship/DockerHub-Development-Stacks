FROM vedarth/sles

RUN zypper update -y && \
  zypper install -y python-jinja2 python-httplib2 gcc libffi-devel python3-devel openssl-devel 

RUN pip install --upgrade pip

RUN pip install ansible

ENTRYPOINT	["/usr/bin/ansible-playbook", "-i", "/etc/ansible/hosts"]
