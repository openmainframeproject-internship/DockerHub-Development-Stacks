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

zypper -c ${zypp_config} --root=${target} --releasever=/ \
    --non-interactive --no-gpg-checks addrepo \
    /etc/zypp/repos.d/Basesystem_Module_15_s390x:SLE-Module-Basesystem15-Debuginfo-Pool.repo /etc/zypp/repos.d/Basesystem_Module_15_s390x:SLE-Module-Basesystem15-Debuginfo-Updates.repo /etc/zypp/repos.d/Basesystem_Module_15_s390x:SLE-Module-Basesystem15-Pool.repo /etc/zypp/repos.d/Basesystem_Module_15_s390x:SLE-Module-Basesystem15-Source-Pool.repo /etc/zypp/repos.d/Basesystem_Module_15_s390x:SLE-Module-Basesystem15-Updates.repo /etc/zypp/repos.d/Containers_Module_15_s390x:SLE-Module-Containers15-Debuginfo-Pool.repo /etc/zypp/repos.d/Containers_Module_15_s390x:SLE-Module-Containers15-Debuginfo-Updates.repo /etc/zypp/repos.d/Containers_Module_15_s390x:SLE-Module-Containers15-Pool.repo /etc/zypp/repos.d/Containers_Module_15_s390x:SLE-Module-Containers15-Source-Pool.repo /etc/zypp/repos.d/Containers_Module_15_s390x:SLE-Module-Containers15-Updates.repo /etc/zypp/repos.d/Desktop_Applications_Module_15_s390x:SLE-Module-Desktop-Applications15-Debuginfo-Pool.repo /etc/zypp/repos.d/Desktop_Applications_Module_15_s390x:SLE-Module-Desktop-Applications15-Debuginfo-Updates.repo /etc/zypp/repos.d/Desktop_Applications_Module_15_s390x:SLE-Module-Desktop-Applications15-Pool.repo /etc/zypp/repos.d/Desktop_Applications_Module_15_s390x:SLE-Module-Desktop-Applications15-Source-Pool.repo /etc/zypp/repos.d/Desktop_Applications_Module_15_s390x:SLE-Module-Desktop-Applications15-Updates.repo /etc/zypp/repos.d/Development_Tools_Module_15_s390x:SLE-Module-DevTools15-Debuginfo-Pool.repo /etc/zypp/repos.d/Development_Tools_Module_15_s390x:SLE-Module-DevTools15-Debuginfo-Updates.repo /etc/zypp/repos.d/Development_Tools_Module_15_s390x:SLE-Module-DevTools15-Pool.repo /etc/zypp/repos.d/Development_Tools_Module_15_s390x:SLE-Module-DevTools15-Source-Pool.repo /etc/zypp/repos.d/Development_Tools_Module_15_s390x:SLE-Module-DevTools15-Updates.repo SLES15-15-0.repo /etc/zypp/repos.d/SUSE_Linux_Enterprise_Server_15_s390x:SLE-Product-SLES15-Debuginfo-Pool.repo /etc/zypp/repos.d/SUSE_Linux_Enterprise_Server_15_s390x:SLE-Product-SLES15-Debuginfo-Updates.repo /etc/zypp/repos.d/SUSE_Linux_Enterprise_Server_15_s390x:SLE-Product-SLES15-Pool.repo /etc/zypp/repos.d/SUSE_Linux_Enterprise_Server_15_s390x:SLE-Product-SLES15-Source-Pool.repo /etc/zypp/repos.d/SUSE_Linux_Enterprise_Server_15_s390x:SLE-Product-SLES15-Updates.repo /etc/zypp/repos.d/SUSE_Package_Hub_15_s390x:SLE-Module-Packagehub-Subpackages15-Debuginfo-Pool.repo /etc/zypp/repos.d/SUSE_Package_Hub_15_s390x:SLE-Module-Packagehub-Subpackages15-Debuginfo-Updates.repo /etc/zypp/repos.d/SUSE_Package_Hub_15_s390x:SLE-Module-Packagehub-Subpackages15-Pool.repo /etc/zypp/repos.d/SUSE_Package_Hub_15_s390x:SLE-Module-Packagehub-Subpackages15-Source-Pool.repo /etc/zypp/repos.d/SUSE_Package_Hub_15_s390x:SLE-Module-Packagehub-Subpackages15-Updates.repo /etc/zypp/repos.d/SUSE_Package_Hub_15_s390x:SUSE-PackageHub-15-Debuginfo.repo SUSE_Package_Hub_15_s390x:SUSE-PackageHub-15-Pool.repo /etc/zypp/repos.d/SUSE_Package_Hub_15_s390x:SUSE-PackageHub-15-Standard-Pool.repo /etc/zypp/repos.d/Server_Applications_Module_15_s390x:SLE-Module-Server-Applications15-Debuginfo-Pool.repo /etc/zypp/repos.d/Server_Applications_Module_15_s390x:SLE-Module-Server-Applications15-Debuginfo-Updates.repo /etc/zypp/repos.d/Server_Applications_Module_15_s390x:SLE-Module-Server-Applications15-Pool.repo /etc/zypp/repos.d/Server_Applications_Module_15_s390x:SLE-Module-Server-Applications15-Source-Pool.repo /etc/zypp/repos.d/Server_Applications_Module_15_s390x:SLE-Module-Server-Applications15-Updates.repo /etc/zypp/repos.d/Web_and_Scripting_Module_15_s390x:SLE-Module-Web-Scripting15-Debuginfo-Pool.repo /etc/zypp/repos.d/Web_and_Scripting_Module_15_s390x:SLE-Module-Web-Scripting15-Debuginfo-Updates.repo /etc/zypp/repos.d/Web_and_Scripting_Module_15_s390x:SLE-Module-Web-Scripting15-Pool.repo /etc/zypp/repos.d/Web_and_Scripting_Module_15_s390x:SLE-Module-Web-Scripting15-Source-Pool.repo /etc/zypp/repos.d/Web_and_Scripting_Module_15_s390x:SLE-Module-Web-Scripting15-Updates.repo
#zypper -c ${zypp_config} --installroot=${target} clean all

cat > ${target}/etc/sysconfig/network <<EOF
NETWORKING=yes
HOSTNAME=localhost.localdomain
EOF

sed -i'' -e '/distroverpkg/s/$/\' ${target}/etc/zypp/zypp.conf

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
