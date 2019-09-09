FROM	vedarth/sles

RUN zypper update -y
RUN zypper install -y python-qpid qpid-cpp-server

ADD 		. /.qpidd

WORKDIR 	/.qpidd

EXPOSE 		5672

ENTRYPOINT 	["qpidd", "-t", "--auth=no"]
