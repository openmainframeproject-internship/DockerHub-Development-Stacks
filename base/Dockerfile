FROM scratch

ADD 	sles-15-docker.tar.xz /

RUN zypper ref -s
RUN zypper -n in vim

LABEL 	name="SLES Base Image" \
	vendor="SLES" \
	license="GPLv2" \
	build-date="20190527"

CMD 	["/bin/bash"]
