FROM vedarth/sles

RUN zypper ar -f --no-check --no-gpgcheck https://download.opensuse.org/repositories/openSUSE:/Backports:/SLE-15-SP1/standard/openSUSE:Backports:SLE-15-SP1.repo

RUN 	zypper update -y && \
  zypper install -y gnu-cobol

VOLUME		work
