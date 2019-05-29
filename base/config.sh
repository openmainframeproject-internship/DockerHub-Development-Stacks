usage() {
    cat <<EOOPTS
$(basename $0) [OPTIONS] 
OPTIONS:
  -y <zyppconf>  The path to the zypp config to install packages from. The
                default is /etc/zypp/zypp.conf.
EOOPTS
    exit 1
}

# option defaults
version=""
export PATH=/usr/local/bin:${PATH}
zypp_config=/etc/zypp/zypp.conf
while getopts "y:v:h" opt; do
    case $opt in
        y)
            zypp_config=$OPTARG
            ;;
        h)
            usage
            ;;
        \?)
            echo "Invalid option: -$OPTARG"
            usage
            ;;
    esac
done
shift $((OPTIND - 1))

name="sles"
version="sles15"

#--------------------

zypper clean -a

export TMPDIR=/var/tmp
target=$(mktemp -d --tmpdir $(basename $0).XXXXXX)

mkdir -m 755 ${target}/dev
mknod -m 600 ${target}/dev/console c 5 1
mknod -m 600 ${target}/dev/initctl p
mknod -m 666 ${target}/dev/full c 1 7
mknod -m 666 ${target}/dev/null c 1 3
mknod -m 666 ${target}/dev/ptmx c 5 2
mknod -m 666 ${target}/dev/random c 1 8
mknod -m 666 ${target}/dev/tty c 5 0
mknod -m 666 ${target}/dev/tty0 c 4 0
mknod -m 666 ${target}/dev/urandom c 1 9
mknod -m 666 ${target}/dev/zero c 1 5

if [ -d /etc/zypp/vars ]; then
	mkdir -p -m 755 ${target}/etc/zypp
	cp -a /etc/zypp/vars ${target}/etc/zypp/
fi

zypper -c ${zypp_config} --installroot=${target} --releasever=/ \
    --non-interactive --no-gpg-checks install cracklib-dict-small filesystem libtirpc-netconfig perl-base libuuid libsmartcols libnettle libgcc_s libcap-ng libmagic1 libstdc++ libfdisk terminfo-base libreadline libverto libunistring libpopt libnpth liblzma libkeyutils libgmp libcap libaudit kubic-locale-archive libmodman cracklib libselinux libassuan libdw libboost_thread libpsl info pinentry findutils cpio libxml libhogweed libacl libmount libtasn libtirpc libtasn libgnutls sed libusb libnsl procps permissions libsolv-tools libgpgme libzypp sysuser-shadow libutempter aaa_base container-suseconnect p11-kit-tools suse-build-key ca-certificates boost-license system-user-root file-magic glibc libz libsqlite3 libsasl liblua libcom_err libopenssl libblkid libldap libncurses ncurses-utils bash libustr libsepol libpcre libnghttp liblz libgpg-error libffi libbz libattr fillup libboost_system libidn libksba libzio libproxy libcrack libsemanage libebl-plugins grep diffutils libelf libgcrypt libp11-kit libudev krb libsystemd libssh libcurl libaugeas coreutils libprocps sles-release rpm gpg pam shadow zypper system-group-hardware util-linux netcfg openssl p11-kit openssl ca-certificates-mozilla
 #zypper -c ${zypp_config} --installroot=${target} clean all

cp -ar /etc/zypp/repos.d ${target}/etc/zypp

cat > ${target}/etc/sysconfig/network/conf <<EOF
NETWORKING=yes
HOSTNAME=localhost.localdomain
EOF

sed -i'' -e '/distroverpkg/s/$/\ntsflags=nodocs/' ${target}/etc/zypp/zypp.conf

# effectively: febootstrap-minimize --keep-zoneinfo --keep-rpmdb
# --keep-services ${target}.  Stolen from mkimage-rinse.sh
#  locales
rm -rf ${target}/usr/{{lib,share}/locale,{lib,lib64}/gconv,bin/localedef,sbin/build-locale-archive}
#  docs
rm -rf ${target}/usr/share/{man,doc,info,gnome/help}
#  cracklib
rm -rf ${target}/usr/share/cracklib
#  i18n
rm -rf ${target}/usr/share/i18n
#  sln
rm -rf ${target}/sbin/sln
#  ldconfig
rm -rf ${target}/etc/ld.so.cache
rm -rf ${target}/var/cache/ldconfig/*
# tmp
rm -rf ${target}/tmp/*

if [ -z "${version}" ]; then
	for file in ${target}/etc/{redhat,system,clefos,centos,sles}-release
	do
	    if [ -r "${file}" ]; then
		version="$(sed 's/^[^0-9\]*\([0-9.]\+\).*$/\1/' ${file})"
		break
	    fi
	done
fi

if [ -z "${version}" ]; then
    echo >&2 "warning: cannot autodetect OS version, using '${name}' as tag"
    version="${name}"
fi
tar -cJf sles-15-docker.tar.xz --numeric-owner -c -C ${target} .
rm -rf ${target}
