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
    sles-release \
    SLE-Module-Basesystem15-Debuginfo-Pool SLE-Module-Basesystem15-Debuginfo-Updates SLE-Module-Basesystem15-Pool SLE-Module-Basesystem15-Source-Pool SLE-Module-Basesystem15-Updates SLE-Module-Containers15-Debuginfo-Pool SLE-Module-Containers15-Debuginfo-Updates SLE-Module-Containers15-Pool SLE-Module-Containers15-Source-Pool SLE-Module-Containers15-Updates SLE-Module-Desktop-Applications15-Debuginfo-Pool SLE-Module-Desktop-Applications15-Debuginfo-Updates SLE-Module-Desktop-Applications15-Pool \
    SLE-Module-Desktop-Applications15-Source-Pool SLE-Module-Desktop-Applications15-Updates SLE-Module-DevTools15-Debuginfo-Pool SLE-Module-DevTools15-Debuginfo-Updates SLE-Module-DevTools15-Pool SLE-Module-DevTools15-Source-Pool SLE-Module-DevTools15-Updates SLES15-15-0 SLE-Product-SLES15-Debuginfo-Pool SLE-Product-SLES15-Debuginfo-Updates SLE-Product-SLES15-Pool SLE-Product-SLES15-Source-Pool SLE-Product-SLES15-Updates SLE-Module-Packagehub-Subpackages15-Debuginfo-Pool SLE-Module-Packagehub-Subpackages15-Debuginfo-Updates
SLE-Module-Packagehub-Subpackages15-Pool SLE-Module-Packagehub-Subpackages15-Source-Pool SLE-Module-Packagehub-Subpackages15-Updates SUSE-PackageHub-15-Debuginfo SUSE-PackageHub-15-Pool SUSE-PackageHub-15-Standard-Pool SLE-Module-Server-Applications15-Debuginfo-Pool SLE-Module-Server-Applications15-Debuginfo-Updates SLE-Module-Server-Applications15-Pool SLE-Module-Server-Applications15-Source-Pool SLE-Module-Server-Applications15-Updates SLE-Module-Web-Scripting15-Debuginfo-Pool SLE-Module-Web-Scripting15-Debuginfo-Updates SLE-Module-Web-Scripting15-Pool SLE-Module-Web-Scripting15-Source-Pool SLE-Module-Web-Scripting15-Updates

#cp oss.repo ${target}/etc/zypp/repos.d/.

zypper -c ${zypp_config} --installroot=${target} --releasever=/ \
    --enablerepo=oss --nogpgcheck \
    sna-packages 

rm -f ${target}/etc/zypper/repos.d/sna.repo

zypper -c ${zypp_config} --installroot=${target} clean all

rpmkeys --import --root=${target} ${target}/etc/pki/rpm-gpg/RPM-GPG-KEY-SNA

cat > ${target}/etc/sysconfig/network <<EOF
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
