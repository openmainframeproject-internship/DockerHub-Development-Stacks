FROM 		vedarth/sles

RUN 		zypper update -y && zypper install -y \
			bzip2 \
			curl \
			tar \
			which \
			systemd \
			gcc \
			make \

# pub   1024D/ACC9965B 2006-12-12
#       Key fingerprint = C9E9 416F 76E6 10DB D09D  040F 47B7 0C55 ACC9 965B
# uid                  Denis Vlasenko <vda.linux@googlemail.com>
# sub   1024g/2C766641 2006-12-12
RUN 		gpg --keyserver ha.pool.sks-keyservers.net --recv-keys C9E9416F76E610DBD09D040F47B70C55ACC9965B

RUN 		set -ex; \
		tarball="busybox-1.26.2.tar.bz2"; \
		curl -fL -o busybox.tar.bz2 "https://busybox.net/downloads/$tarball"; \
		curl -fL -o busybox.tar.bz2.sign "https://busybox.net/downloads/$tarball.sign"; \
		gpg --batch --decrypt --output busybox.tar.bz2.txt busybox.tar.bz2.sign; \
		awk '$1 == "SHA1:" && $2 ~ /^[0-9a-f]+$/ && $3 == "'"$tarball"'" { print $2, "*busybox.tar.bz2" }' busybox.tar.bz2.txt > busybox.tar.bz2.sha1; \
		test -s busybox.tar.bz2.sha1; \
		sha1sum -c busybox.tar.bz2.sha1; \
		mkdir -p /usr/src/busybox; \
		tar -xf busybox.tar.bz2 -C /usr/src/busybox --strip-components 1; \
		rm busybox.tar.bz2*

WORKDIR 	/usr/src/busybox

# CONFIG_LAST_SUPPORTED_WCHAR: see https://github.com/docker-library/busybox/issues/13 (UTF-8 input)
# As long as we rely on libnss, we have to have libc.so anyhow, so
# we've removed CONFIG_STATIC here for now... :cry:
RUN 		set -ex; \
		\
		setConfs=' \
			CONFIG_AR=y \
			CONFIG_FEATURE_AR_CREATE=y \
			CONFIG_FEATURE_AR_LONG_FILENAMES=y \
			CONFIG_LAST_SUPPORTED_WCHAR=0 \
		'; \
		\
		unsetConfs=' \
			CONFIG_FEATURE_SYNC_FANCY \
		'; \
		\
		make defconfig; \
		\
		for conf in $unsetConfs; do \
			sed -i \
				-e "s!^$conf=.*\$!# $conf is not set!" \
				.config; \
		done; \
		\
		for confV in $setConfs; do \
			conf="${confV%=*}"; \
			sed -i \
				-e "s!^$conf=.*\$!$confV!" \
				-e "s!^# $conf is not set\$!$confV!" \
				.config; \
			if ! grep -q "^$confV\$" .config; then \
				echo "$confV" >> .config; \
			fi; \
		done; \
		\
		make oldconfig; \
		\
# trust, but verify
		for conf in $unsetConfs; do \
			! grep -q "^$conf=" .config; \
		done; \
		for confV in $setConfs; do \
			grep -q "^$confV\$" .config; \
		done;

RUN 		set -ex \
		&& make -j "$(nproc)" \
			busybox \
		&& ./busybox --help \
		&& mkdir -p rootfs/bin \
		&& ln -vL busybox rootfs/bin/ \
		\
		&& ln -vL "$(which getconf)" rootfs/bin/getconf \
		\
	# hack hack hack hack hack
	# with glibc, static busybox uses libnss for DNS resolution :(
		&& mkdir -p rootfs/etc \
		&& cp /etc/nsswitch.conf rootfs/etc/ \
		&& mkdir -p rootfs/lib \
		&& ln -sT lib rootfs/lib64 \
		&& set -- \
			rootfs/bin/busybox \
			rootfs/bin/getconf \
			/usr/lib64/libnss*.so.* \
	# libpthread is part of glibc: http://stackoverflow.com/a/11210463/433558
			/usr/lib64/libpthread*.so.* \
		&& while [ "$#" -gt 0 ]; do \
			f="$1"; shift; \
			fn="$(basename "$f")"; \ 
			if [ -e "rootfs/lib/$fn" ]; then continue; fi; \
			if [ "${f#rootfs/}" = "$f" ]; then \
				if [ "${fn#ld-}" = "$fn" ]; then \
					ln -vL "$f" "rootfs/lib/$fn"; \
				else \
					cp -v "$f" "rootfs/lib/$fn"; \
				fi; \
			fi; \
			set -- "$@" $(ldd "$f" | awk ' \
				$1 ~ /^\// { print $1; next } \
				$2 == "=>" && $3 ~ /^\// { print $3; next } \
			'); \
		done \
		\
		&& chroot rootfs /bin/getconf _NPROCESSORS_ONLN \
		\
		&& chroot rootfs /bin/busybox --install /bin

RUN 		set -ex; \
		buildrootVersion='2017.02.2'; \
		mkdir -p rootfs/etc; \
		for f in passwd shadow group; do \
			curl -fL -o "rootfs/etc/$f" "https://git.busybox.net/buildroot/plain/system/skeleton/etc/$f?id=$buildrootVersion"; \
		done

# create /tmp
RUN 		mkdir -p rootfs/tmp \
		&& chmod 1777 rootfs/tmp

# create missing home directories
RUN 		set -ex \
		&& cd rootfs \
		&& for userHome in $(awk -F ':' '{ print $3 ":" $4 "=" $6 }' etc/passwd); do \
			user="${userHome%%=*}"; \
			home="${userHome#*=}"; \
			home="./${home#/}"; \
			if [ ! -d "$home" ]; then \
				mkdir -p "$home"; \
				chown "$user" "$home"; \
			fi; \
		done

# test and make sure it works
RUN 		chroot rootfs /bin/sh -xec 'true'

# ensure correct timezone (UTC)
RUN 		ln -v /etc/localtime rootfs/etc/ \
		&& [ "$(chroot rootfs date +%Z)" = 'UTC' ]

# test and make sure DNS works too
RUN 		cp -L /etc/resolv.conf rootfs/etc/ \
		&& chroot rootfs /bin/sh -xec 'nslookup google.com' || true \
		&& rm rootfs/etc/resolv.conf
