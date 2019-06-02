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

zypper -c ${zypp_config} --root=${target} \
    addrepo -G --check --refresh https://updates.suse.com/SUSE/Products/SLE-Module-Basesystem/15/s390x/product_debug?LOK75mM2xow1_nP7c-EFx3gp11e5SShy3KCsBseI2IZeOMLYgB5NJPVlp9Dc5h-8qZbAMSSZQCPjGyXZgapalW7yz851xP_2lrgKie59lCmc4EcxPeuYJ-N68uJlBh7qpKiDT-DLe1O1Lau7EtCFUd47IQOpZ_2NoQ Basesystem_Module_15_s390x:SLE-Module-Basesystem15-Debuginfo-Pool
zypper -c ${zypp_config} --root=${target} \
    addrepo -G --check --refresh https://updates.suse.com/SUSE/Updates/SLE-Module-Basesystem/15/s390x/update_debug?ejveK1HHFQAAAAAAOo6S7ljv6YGSdMS7zlOST1q4qRqQghWO1Mg7ibpRjOtelmr_iKmx9VOtVCLoQ6EGVv4tQkonxwAObrVFyeJOpk2p48If-22sKbwzH1Hd-IPQoxOXgLheCEojZfj7TaijLftu1l0Tf8p_aKY Basesystem_Module_15_s390x:SLE-Module-Basesystem15-Debuginfo-Updates
zypper -c ${zypp_config} --root=${target} \
    addrepo -G --check --refresh https://updates.suse.com/SUSE/Products/SLE-Module-Basesystem/15/s390x/product?6WkbPvVbyaRLts1_ntorHX0ex7to4F4R_R4kWUNwl6vxT6zOy4Mal8pNtqMGJV1FTPo5RUDGEwH1yCfUhiZYCK6GN_UimCrR8o8Amspbq249U4wnCVjEFTRtdZzHyVmHli3aqhRn3IGxJc9OYzopDAMVBA Basesystem_Module_15_s390x:SLE-Module-Basesystem15-Pool
zypper -c ${zypp_config} --root=${target} \
    addrepo -G --check --refresh https://updates.suse.com/SUSE/Products/SLE-Module-Basesystem/15/s390x/product_source?_SXzLvD0tIkfmCpZW_-DKFpMlFDpmX-FRPPuMqicVPertNe7nUNtdmeklBpWlpo1iNYvyOFtxKu4NTRPYMRj7f12BdGrLf2XZ0Zs0d1lk_xDGhXpUdpBzIk8km7cODZcgw5yLfIQ7Lh_AOEB9iD3u7LIkS1zAMkyln4 Basesystem_Module_15_s390x:SLE-Module-Basesystem15-Source-Pool
zypper -c ${zypp_config} --root=${target} \
    addrepo -G --check --refresh https://updates.suse.com/SUSE/Updates/SLE-Module-Basesystem/15/s390x/update?FaauIkD-PCZZt4Z6HPpEGv9cp9LeQKfIAK_ZCn49B0bQQwNOc3PREZ5tPE69ZHclJv-vbFjsFsKik0EudMHMvv4-eocNKJw2ADTnZkY8ie1MWvL2DeVNYoSDsnG4XSRFQsWNj16gtu3FEGSliCO-9To Basesystem_Module_15_s390x:SLE-Module-Basesystem15-Updates
zypper -c ${zypp_config} --root=${target} \
    addrepo -G --check --refresh https://updates.suse.com/SUSE/Products/SLE-Module-Containers/15/s390x/product_debug?4_hXeqTJ761sdu9J9c_jy0daTLVZS3TZoppnyHmUF8K3l1MLYWBvCYeBcSfQtj4Tnbi9HfjeISUO4fPeGoGN21lrUpSXwkLDgGASIv0SiJvtpPafGtMR1pi4PYi_FznqvuSd54ggRWu3BiWDo6LL884CwuesuErdiA Containers_Module_15_s390x:SLE-Module-Containers15-Debuginfo-Pool
zypper -c ${zypp_config} --root=${target} \
    addrepo -G --check --refresh https://updates.suse.com/SUSE/Updates/SLE-Module-Containers/15/s390x/update_debug?yvh9HfwqeuDEz32UmEN3KzPqMSoKyybzIukyW9sVO4SAlQHeMLhLtFxoWeioJs-5KBHr6xS6_o6hrtQikdCjB-iVJMv7BtbSlHwLnsXd0EhxJ3Jejx8ylCdaHqMX6eAqlBvjSn_bEwTPDdUiimXyoip1Y6JW21c Containers_Module_15_s390x:SLE-Module-Containers15-Debuginfo-Updates
zypper -c ${zypp_config} --root=${target} \
    addrepo -G --check --refresh https://updates.suse.com/SUSE/Products/SLE-Module-Containers/15/s390x/product?eCr1epDRWr8v6hS3DR__gFw9q49sPBXGWeCM_Yaq3rOEzwFME4FKdc-e9KmXTopf-ILLwIUp3GjE4cLSPlTl9a7zTQrEFEYieA7Bgp2HXcOVVA5zGGs9hzHJjK6Ti44G5DgEY-WXZ4-twInTmTolXAvk2Q Containers_Module_15_s390x:SLE-Module-Containers15-Pool
zypper -c ${zypp_config} --root=${target} \
    addrepo -G --check --refresh https://updates.suse.com/SUSE/Products/SLE-Module-Containers/15/s390x/product_source?kdUq-hAW28qakm2O1q1j9Cnz5RxBJa7umT8pZg2uvrRIssRXpQxfihvxpH-mvJn2ZuGT-5d3XBOed1pjWiLGQhU43FicC1sGeaI3SqnwX9eoETSC2DUWM_r3mFvowNPdz7R4zkLufbNtIRG40dlvQrlkBfc_PCyItzA Containers_Module_15_s390x:SLE-Module-Containers15-Source-Pool
zypper -c ${zypp_config} --root=${target} \
    addrepo -G --check --refresh https://updates.suse.com/SUSE/Updates/SLE-Module-Containers/15/s390x/update?5pl0YKs5DbKQyzvRCeZq9ldmoYei50B0qi2VD2vu6piMgBbXM2rTNig4FTYgOb9PxohZHyzMR8iUIBq-gMCxAtTbTrQrCBQDx6-5PVhlzaDgVw1foZ-YYCxnzB9iEo-QxySc3hLUaVa3zrqAusL3HLo Containers_Module_15_s390x:SLE-Module-Containers15-Updates
zypper -c ${zypp_config} --root=${target} \
    addrepo -G --check --refresh https://updates.suse.com/SUSE/Products/SLE-Module-Desktop-Applications/15/s390x/product_debug?-gPPuXfs6Nhf1U53vsnUULSz-nkmgXNwa8-5yB2FD6xU_eZJ89tUXUe6PJLdJk6myPI_pA9gSoGl4fj_t2vFRIXaq9D47QZGJkRKP8VAQAT3lDUory_EHp2B0MmCxTcqVtkfTFLL_s5r1iCHbFetKnosUjOwauai6jvcjS7fpyIkHsg Desktop_Applications_Module_15_s390x:SLE-Module-Desktop-Applications15-Debuginfo-Pool
zypper -c ${zypp_config} --root=${target} \
    addrepo -G --check --refresh https://updates.suse.com/SUSE/Updates/SLE-Module-Desktop-Applications/15/s390x/update_debug?vqqMFJyji8GeTSUanv2Zs1mxcnUXl-kpDDu7Q0_Mil-N-ohtrES2OdySXQEMMwyl6fZaG6KUoM23ni_yK74jNnWCqE_zwFtsJZXLjN0omUXJ-yAj0mAxrc61GyDvebw6L5JUAOVqf6lWP_9mdQuOkoD9GGACFWcZ_eVsXdJ7aRmD Desktop_Applications_Module_15_s390x:SLE-Module-Desktop-Applications15-Debuginfo-Updates
zypper -c ${zypp_config} --root=${target} \
    addrepo -G --check --refresh https://updates.suse.com/SUSE/Products/SLE-Module-Desktop-Applications/15/s390x/product?lMOvyqAsfMHfwBsaypBlce2vH15ZIniYkjJh0NZBIEJ7qQR-cGqGVf2LMdYTHlYycY2XdGAX95UpQwLOnF0cvY8G7yFH-qS9_3LLTIsispzrUkfEqXjSfA-sulY8zCPE96ZdflRcLuPSEozhtSqxcZevR0zQlaCOqCesSjU Desktop_Applications_Module_15_s390x:SLE-Module-Desktop-Applications15-Pool
zypper -c ${zypp_config} --root=${target} \
    addrepo -G --check --refresh https://updates.suse.com/SUSE/Products/SLE-Module-Desktop-Applications/15/s390x/product_source?YlqJLDTDOUJ5lLjQYvIkOn8bc_P3zqQOww20JQj88GGhL_aI_2MDIGBTU1RKR3srUYUN5POYfXwW7udwI4qEVnEkMz71FPUUT7z9fg4V8FgA116X_wXoH1JsaMPVQxHpasA72JlddTatmWd2VfBSvwEDa6zB9i_f4G_q9sTv7MmQNmXC Desktop_Applications_Module_15_s390x:SLE-Module-Desktop-Applications15-Source-Pool
zypper -c ${zypp_config} --root=${target} \
    addrepo -G --check --refresh https://updates.suse.com/SUSE/Updates/SLE-Module-Desktop-Applications/15/s390x/update?kJ1LOKPSlsHQoBnxYVoBJB0tCDuczBkcH7Q24Atm5jEpJzG75wfqnMzWJkobBz4yC-YzmiZXRyXDRfx_HUzVX5tYVd5Njt_Ud4sHbbQAlaPHGEHxNQ6YeJpn2VrBuqE96q2XRyxy1npOcC2Fw32MA4jZ7mTvN4s8TMqg Desktop_Applications_Module_15_s390x:SLE-Module-Desktop-Applications15-Updates
zypper -c ${zypp_config} --root=${target} \
    addrepo -G --check --refresh https://updates.suse.com/SUSE/Products/SLE-Module-Development-Tools/15/s390x/product_debug?t0yyKr3k27nB6FW8nWSu6P__DWlxguii7vIpj1U3TVjCz4azcpc5jk_cx0moFAp2z3etWbmQIG15fFNFAKEOtlzw2qCnD-7cv8BnEZdRN6vFgB8Uipl1NqMD4N0JRGnWb-62s3I1n4S7lnYZ1NXMvexvUEwq_vA4iNDU-6iUyMU Development_Tools_Module_15_s390x:SLE-Module-DevTools15-Debuginfo-Pool
zypper -c ${zypp_config} --root=${target} \
    addrepo -G --check --refresh https://updates.suse.com/SUSE/Updates/SLE-Module-Development-Tools/15/s390x/update_debug?a8TPNWaypbdHseqoJN7e-3VXNtDuT4mXH8vR9ocU3EeMT8_oMj7tL3Wm5V6TWbyDfmYMXl9GoQM9L7jfANfZbcSsumPc-qmNVqomaAH145dUNnvSURSLux7uG_Y48qY_zrwwYKpeeU7bEFoHyuH0YNhxetdQU1Zb7s9xn16q Development_Tools_Module_15_s390x:SLE-Module-DevTools15-Debuginfo-Updates
zypper -c ${zypp_config} --root=${target} \
    addrepo -G --check --refresh https://updates.suse.com/SUSE/Products/SLE-Module-Development-Tools/15/s390x/product?MVmScxI_YK5n0IpyIwDVfgvx6Z4u9kPlO--FCZ5qpm5ES7rchq1nrbcl4BWlDaDCrfn05928ie3gl1pPqFReX_yG2wYJci9CKfaOOjmio-w4KYBxVv6kWwqc0PUXy4tu49zCON1oC80JCtTRCf4RhrWUTkAp2QIb970 Development_Tools_Module_15_s390x:SLE-Module-DevTools15-Pool
zypper -c ${zypp_config} --root=${target} \
    addrepo -G --check --refresh https://updates.suse.com/SUSE/Products/SLE-Module-Development-Tools/15/s390x/product_source?_5SLTjuxUSGb470YR0HHzCWyQ-CLbi_dvqCIifodQ1TBkl5lO10GfC7lLm6REvFRUTJuyTX_5V01-Y6bsc2AVt1Ylkha07JyH9hfL2LohFm0gCguLD0AgkCWLa9s0byIaxlPUvSVCNWBNT-uJ5fGW1vhHXAMBlMWEQ9oVEHDUum7 Development_Tools_Module_15_s390x:SLE-Module-DevTools15-Source-Pool
zypper -c ${zypp_config} --root=${target} \
    addrepo -G --check --refresh https://updates.suse.com/SUSE/Updates/SLE-Module-Development-Tools/15/s390x/update?OSpqFK2uUnLUpCfRHRTjRndlqVNQX47joE3Dm9SE2tpeBShbG65yfgpdmMrmmM9P6_I5Ggaau7Be-afIu0aYsIYtfGi-ug9bQf8S19mCdjEQZqajYPRnSlfHFVG382t4iXSsHkwuC8z5sKaP-gdgZLR5qAN7aR4f Development_Tools_Module_15_s390x:SLE-Module-DevTools15-Updates
zypper -c ${zypp_config} --root=${target} \
    addrepo -G --check --refresh http://aussie-2.lf-dev.marist.edu/SLES15 SLES15-15-0
zypper -c ${zypp_config} --root=${target} \
    addrepo -G --check --refresh https://updates.suse.com/SUSE/Products/SLE-Product-SLES/15/s390x/product_debug?FNLuvlFSbqHwlxkwyBwJ0iNXp-8VBsw0TpwdiayReS7T31_2HaMuubJD4i1ZJ1lbfaVEpHiuqFnwnB4zlQCoZn3RFfRcsbrQXBRu6hwxJCP2sNH06-8h-XjAztmX-KIV2pwQ2tpEiMY0XSQqv0XbdxzGe6U SUSE_Linux_Enterprise_Server_15_s390x:SLE-Product-SLES15-Debuginfo-Pool
zypper -c ${zypp_config} --root=${target} \
    addrepo -G --check --refresh https://updates.suse.com/SUSE/Updates/SLE-Product-SLES/15/s390x/update_debug?pO_cUgmkLNRMS-8sep5_P_QfootRnbePWItHgRGr6Q2B5960rwUwcmgmsmCFDBCNF4VYaDCX5aSTw7Hs91hmltUHYoqLClZagQV81TiT0GzKzbUEaI8ozolOll3TKGmnHL-KvdSMhtMYDWOA4RqKkG7I SUSE_Linux_Enterprise_Server_15_s390x:SLE-Product-SLES15-Debuginfo-Updates
zypper -c ${zypp_config} --root=${target} \
    addrepo -G --check --refresh https://updates.suse.com/SUSE/Products/SLE-Product-SLES/15/s390x/product?6cBNeN8wScJktFSaS6PGPh5eovvyFpy6iSC6vDGs4-lt2YXmJ4GjGwM4Uex2V9wKJAI6TiiYQejgPgmuwJNhm7oaR08bjTxskuYF4Y9V53NysPs4A67RwrNpSwzE2pY8WEVjcAIi8mVK_sm_tfg SUSE_Linux_Enterprise_Server_15_s390x:SLE-Product-SLES15-Pool
zypper -c ${zypp_config} --root=${target} \
    addrepo -G --check --refresh https://updates.suse.com/SUSE/Products/SLE-Product-SLES/15/s390x/product_source?komI6T3VU80KHu7D8n8VZuketf3W4XTTg37gWPPza3KkCZkBj-c5qPXZsuD_lPTq13QcrsIEWUkKl49PhL-QYDg0rPVKGYSOXO3K-vkr9CbtigD6X1JOSFQjqK2Cq-i3FZRzn0QeWMVdgOWsYaQJcEMQjsGu SUSE_Linux_Enterprise_Server_15_s390x:SLE-Product-SLES15-Source-Pool
zypper -c ${zypp_config} --root=${target} \
    addrepo -G --check --refresh https://updates.suse.com/SUSE/Updates/SLE-Product-SLES/15/s390x/update?0gAAAAAAAAAAAAAAJ_F95dHmsV2lau4bV5turjhOmGj5ZAp-c3os8jSHOCXF4219_eOLrEAjOBPDcEjnIFPqNOxPiyAouvyqjkWf9KF44dtshe2wR089ZTdchVvLi9t6G5WkQs2LCy3cc8qD SUSE_Linux_Enterprise_Server_15_s390x:SLE-Product-SLES15-Updates
zypper -c ${zypp_config} --root=${target} \
    addrepo -G --check --refresh https://updates.suse.com/SUSE/Products/SLE-Module-Packagehub-Subpackages/15/s390x/product_debug?mmS43D8Pbx_VUyYbgbDVkxoAXUaTl4WFaLGfLMJnALQFBM52-1XSMv4hdDlvsoQvwIzoza2SMpOu8hd9TDbKonWZLdqTpqheTDPqb8tWMSJUFkS4tkp0evnzxviXSiM-UXNuXEIG4r5ph1Z3XYO9wdGUyIJLbLCdtPSz3gh7e71fb0y-nw SUSE_Package_Hub_15_s390x:SLE-Module-Packagehub-Subpackages15-Debuginfo-Pool
zypper -c ${zypp_config} --root=${target} \
    addrepo -G --check --refresh https://updates.suse.com/SUSE/Updates/SLE-Module-Packagehub-Subpackages/15/s390x/update_debug?pxoX59O3IhWqteEtHv2CzZHzxQD0ZHpXZ5JP0uQbYtBk2cf1LF-cJ9yIaUaN2e8dAo8XORCz21OB9M-eLaS9VRd7qFxV2s0qV5_ETP7EpnwVKrJJJ82kzlgfzKo5eIlkDqC3bLVMTi0cx9X_Y2UY9rACxvYztV-g2m8LazlI892mdXY SUSE_Package_Hub_15_s390x:SLE-Module-Packagehub-Subpackages15-Debuginfo-Updates
zypper -c ${zypp_config} --root=${target} \
    addrepo -G --check --refresh https://updates.suse.com/SUSE/Products/SLE-Module-Packagehub-Subpackages/15/s390x/product?4CsMOIyfWFoTUCL2VRG3P4zRTgFr2lqEqF7GJgdtH--810vvRl9RMhuKYKcB_ZQdK2VFGD3V6Q4MFOtlCaeMlgvk_UFgrS6yUS8MkMvbtLIH5-yg7mzkJkxlqaR6NJz8kbPm869nn_eRET0E_99Vxepm_hvOOkuu37kBnFk_EA SUSE_Package_Hub_15_s390x:SLE-Module-Packagehub-Subpackages15-Pool
zypper -c ${zypp_config} --root=${target} \
    addrepo -G --check --refresh https://updates.suse.com/SUSE/Products/SLE-Module-Packagehub-Subpackages/15/s390x/product_source?ust3X3s-C-Td6F3WGAcrgGXOQbpvIPHIRZhzlnQher_xiRxi-I_FmEfIQNNJxPZvqjHdZER758cbcKE73MIVxxuAzzn4RFI3TWZlxNYWke6mjhKay8WlcUE_H0qSARcYxnTwC4nuq1Ebfc36DFM-GDKGHCfq_uxY-PXZt3i05F73_lKj9Js SUSE_Package_Hub_15_s390x:SLE-Module-Packagehub-Subpackages15-Source-Pool
zypper -c ${zypp_config} --root=${target} \
    addrepo -G --check --refresh https://updates.suse.com/SUSE/Updates/SLE-Module-Packagehub-Subpackages/15/s390x/update?E7wWy3QVa8f2r4ARM7M_7YIYmVgfe7zBhenT1z2cugOQGK1mqZ92PZmeCkY7YnQ_BGImzuKgdUihaKw4IHuxBrPUE-qhPM3qAgpCMN63FGmglMrj4MGxZ9kAKeTknIPzGHzfE9awh_nqnpZ7vT7ii7wX0UhYfLTgBjxHIIo SUSE_Package_Hub_15_s390x:SLE-Module-Packagehub-Subpackages15-Updates
zypper -c ${zypp_config} --root=${target} \
    addrepo -G --check --refresh https://updates.suse.com/SUSE/Backports/SLE-15_s390x/standard_debug?GxXBSDPWjYW9OlmpA2FdOEQbBDzAGqOyBPkTFjRB-4KMRmCX__Fz_SiH4Q6o5zK5MR_M37IvHmBKktvfD3VuRoFWciX3PI_wCJDL7MuXPl4YwnVd_T_ZscdTpinA6UPSUg8jvsdvh64J SUSE_Package_Hub_15_s390x:SUSE-PackageHub-15-Debuginfo
zypper -c ${zypp_config} --root=${target} \
    addrepo -G --check --refresh https://updates.suse.com/SUSE/Backports/SLE-15_s390x/product?9vmnVrDcs3-7Pr9eW36aYNEEBrTZL9At7vKiPLcYIWGnIajrW-Pp0KDXMw095CddplkGbmRdMJUiJDbfiTzTmMI5QFKw3_KRMt5JPaUAVJt5yA3_RThNF6yeR6BKiwmVtbM SUSE_Package_Hub_15_s390x:SUSE-PackageHub-15-Pool
zypper -c ${zypp_config} --root=${target} \
    addrepo -G --check --refresh https://updates.suse.com/SUSE/Backports/SLE-15_s390x/standard?r5JmwKlaUg5lq7nnvHO9bFjkGyvB6e76a4SmjBZr9qhmlSIT2SPrenPeFRaGx1ECVT1zBIXZyPCrU9_DsTmZY7aPEKwkQPPK8IhPiTAA5iRNWhiv5gm9R2B2lAFXEACDATCN SUSE_Package_Hub_15_s390x:SUSE-PackageHub-15-Standard-Pool
zypper -c ${zypp_config} --root=${target} \
    addrepo -G --check --refresh https://updates.suse.com/SUSE/Products/SLE-Module-Server-Applications/15/s390x/product_debug?x80ebL7zC4a8vXmaLY_TDJs3XEzpkb0bQvg3ABZDea2HqcZqZT7o79ZblG9Kt_HKGhfpocV13-yladjKjxycMFwypweP27FPXAiF82SRCqcCkwBTC9EffAPO4IRrf2D0pzU1ZpX77c0PmSlIwKkfo04wZqjNUt9RlKNVlAR3qHpTMg Server_Applications_Module_15_s390x:SLE-Module-Server-Applications15-Debuginfo-Pool
zypper -c ${zypp_config} --root=${target} \
    addrepo -G --check --refresh https://updates.suse.com/SUSE/Updates/SLE-Module-Server-Applications/15/s390x/update_debug?2kmkmoPktfS2H-pL9rrYoHNojmpV_4wt_Ihd-usl4HSljm-qBDLympGcpqWH2lkBMNdceSvqoPtA43Ra-40KeSZRKhX_X9Cv2B8NQKgEDQj69kq6Y4h_Lc5Vq4p97iOQTXE5H-KHgg6QffH-531epNVbMNCitZXScg8JyhVr6X4 Server_Applications_Module_15_s390x:SLE-Module-Server-Applications15-Debuginfo-Updates
zypper -c ${zypp_config} --root=${target} \
    addrepo -G --check --refresh https://updates.suse.com/SUSE/Products/SLE-Module-Server-Applications/15/s390x/product?iKof0bhAM7V-mXOBHLaA38BgfwSBnS1NjVxOG2eon__7fKQySU_hW7gvIw4J9kuPVQB-IdrhEXU9PpRH72c9zI8C2xpB8XNJNq5ov3nSBaWv8xPMfpUk-h00V2bHoSzARdP_376EazAIoRncLc_V0b2FsegJvdU1wIXpSQ Server_Applications_Module_15_s390x:SLE-Module-Server-Applications15-Pool
zypper -c ${zypp_config} --root=${target} \
    addrepo -G --check --refresh https://updates.suse.com/SUSE/Products/SLE-Module-Server-Applications/15/s390x/product_source?se8hlRFmEih2YBhJb-mpgStNuXxZjZHPrxQqCHaZ2LAbDDw4Ns8jmxnCIFWGKetnZFtSAck-UxJJSadP88zfK_yovf-Dy58zY41kFKaBhFV4wSvBRzTX-CTHg--g8BEDuBh-HKOXRyaV44TreaxDnNJpWFSgsvdWMjjIq6xyogFbt8I Server_Applications_Module_15_s390x:SLE-Module-Server-Applications15-Source-Pool
zypper -c ${zypp_config} --root=${target} \
    addrepo -G --check --refresh https://updates.suse.com/SUSE/Updates/SLE-Module-Server-Applications/15/s390x/update?382qXopDsBgQtpXtG8aS33XEEIs2DvOtYj4d9t42STaQU764n9iGXCX6wvKCv1j4ANEs_qQoztROssBWM5aUD8Tjidcd6XzEzTWM3JmSm_QPnbq9Zd-KfTNL5iger84KfyTvoUd4R5dNTvD1cRO65c2EImtHfkwXooc Server_Applications_Module_15_s390x:SLE-Module-Server-Applications15-Updates
zypper -c ${zypp_config} --root=${target} \
    addrepo -G --check --refresh https://updates.suse.com/SUSE/Products/SLE-Module-Web-Scripting/15/s390x/product_debug?IKDgIh4WTKV5MRZFEzJF1Pg-A2xibQPZbdagZGnzd7be2zSTdg_jLTPo5LfIFumHJmhBx7L9VvZbfXUnbqekTJ5qGGdGXC1gH4Pk5uDBjaKsx32RVioGMmSJltGnSGEpk73pdFoKcpS1Zi_R7yVuhe_kGo-u52AGYxV3Bw Web_and_Scripting_Module_15_s390x:SLE-Module-Web-Scripting15-Debuginfo-Pool
zypper -c ${zypp_config} --root=${target} \
    addrepo -G --check --refresh https://updates.suse.com/SUSE/Updates/SLE-Module-Web-Scripting/15/s390x/update_debug?dO4mwtts1P5E0jo6yGhwjLa9y7vH6V_ThLrKyd6dmoB2NTkfOOF7w0O_h9w6LqiE9MbZzQFSyo4QCwh2eH_LYLH-9bqCKUA0gbDAc2Dp66S2b_dxSQ2jl2hS9Tc3G2QCHWzGmnWU6q-TQJu9h5nOvtN2rlHOQPS4fbw Web_and_Scripting_Module_15_s390x:SLE-Module-Web-Scripting15-Debuginfo-Updates
zypper -c ${zypp_config} --root=${target} \
    addrepo -G --check --refresh https://updates.suse.com/SUSE/Products/SLE-Module-Web-Scripting/15/s390x/product?9f3PJDV-YLE2NfOOtu-F7SA0iJ_Xsmbh17N2hsJViH980PVcaA7RGxbxUyuzE2CorW6P-XRjF806OI_vVKsLypgnijZSo2ehJPBZ39FR3fiRWunfDFgyagyFN14CeAwBJL85Yaaybi0cF91G8prMCRufYQF_Bw Web_and_Scripting_Module_15_s390x:SLE-Module-Web-Scripting15-Pool
zypper -c ${zypp_config} --root=${target} \
    addrepo -G --check --refresh https://updates.suse.com/SUSE/Products/SLE-Module-Web-Scripting/15/s390x/product_source?WEwfT1EmYW0zZGsBTYchJ9oOetWWp1aMyTK3-PWWsYN2kb1uZ9Rngd6YhHP1Vrzp2SqhoJ6VJqot--h9X3p-WmtZ7WZ58XOvIDXH5sFAf3EWz9FT2CU6iKH_GOftFRk03v3VYy06ayekWeR__TDVwWd-e_xxnLUin1b4-g0 Web_and_Scripting_Module_15_s390x:SLE-Module-Web-Scripting15-Source-Pool
zypper -c ${zypp_config} --root=${target} \
    addrepo -G --check --refresh https://updates.suse.com/SUSE/Updates/SLE-Module-Web-Scripting/15/s390x/update?YBHTB5VZkS9rjhRvKeqUsU5CgroeLrc257OuwOqLsblqBZc1Dex_-qs_NMfIVqsjWQDg9XhzXOjcz0q5atHPvnbaEpy1lvOqEPVIsYntzqQ7WOJyl9L07ea24ot6f3oYjfKrGRKjTmWRcst30hNhg-qK57Y Web_and_Scripting_Module_15_s390x:SLE-Module-Web-Scripting15-Updates

zypper -c ${zypp_config} --root=${target} --releasever=/ \
    --non-interactive  --no-gpg-checks install --auto-agree-with-licenses cracklib-dict-small-2.9.6-2.21 filesystem-15.0-9.2 libtirpc-netconfig-1.0.2-3.8.1 perl-base-5.26.1-7.6.1 libuuid1-2.31.1-9.3.1 libsmartcols1-2.31.1-9.3.1 libnettle6-3.4.1-4.9.1 libgcc_s1-8.2.1+r264010-1.3.7 libcap-ng0-0.7.9-3.3.1 libmagic1-5.32-7.5.1 libstdc++6-8.2.1+r264010-1.3.7 libfdisk1-2.31.1-9.3.1 terminfo-base-6.1-5.3.1 libreadline7-7.0-9.7.1 libverto1-0.2.6-3.20 libunistring2-0.9.9-1.15 libpopt0-1.16-3.22 libnpth0-1.5-2.11 liblzma5-5.2.3-2.20 libkeyutils1-1.5.10-3.42 libgmp10-6.1.2-2.41 libcap2-2.25-2.41 libaudit1-2.8.1-3.30 libmodman1-2.0.1-1.27 cracklib-2.9.6-2.21 libselinux1-2.6-2.21 libassuan0-2.5.1-2.14 libdw1-0.168-2.164 libboost_thread1_66_0-1.66.0-3.10 libpsl5-0.20.1-1.20 info-6.5-4.17 pinentry-1.1.0-2.41 findutils-4.6.0-2.21 cpio-2.12-1.439 libxml2-2-2.9.7-3.6.1 libhogweed4-3.4.1-4.9.1 libacl1-2.2.52-4.3.1 libmount1-2.31.1-9.3.1 libtasn1-6-4.13-4.2.1 libtirpc3-1.0.2-3.8.1 libtasn1-4.13-4.2.1 libgnutls30-3.6.7-6.8.1 sed-4.4-2.11 libusb-1_0-0-1.0.21-1.29 libnsl2-1.2.0-2.44 procps-3.3.12-5.16 permissions-20180125-3.6.1 libsolv-tools-0.6.35-3.5.2 libgpgme11-1.10.0-4.3.4 libzypp-17.7.2-3.16.1 sysuser-shadow-2.0-2.151 libutempter0-1.1.6-3.42 aaa_base-84.87+git20180409.04c9dae-3.6.1 container-suseconnect-2.0.0-4.3.1 p11-kit-tools-0.23.2-4.2.1 suse-build-key-12.0-8.3.1 ca-certificates-2+git20170807.10b2785-7.3.3 boost-license1_66_0-1.66.0-3.10 system-user-root-20170617-1.474 file-magic-5.32-7.5.1 glibc-2.26-13.19.1 libz1-1.2.11-3.6.4 libsqlite3-0-3.28.0-3.6.1 libsasl2-3-2.1.26-5.3.1 liblua5_3-5-5.3.4-3.3.2 libcom_err2-1.43.8-4.3.1 libopenssl1_1-1.1.0i-4.21.1 libblkid1-2.31.1-9.3.1 libldap-2_4-2-2.4.46-9.3.1 libncurses6-6.1-5.3.1 ncurses-utils-6.1-5.3.1 bash-4.4-9.7.1 libustr-1_0-1-1.0.4-2.20 libsepol1-2.6-1.152 libpcre1-8.41-4.20 libnghttp2-14-1.31.1-1.15 liblz4-1-1.8.0-1.33 libgpg-error0-1.29-1.8 libffi7-3.2.1.git259-3.16 libbz2-1-1.0.6-3.22 libattr1-2.4.47-2.19 fillup-1.42-2.18 libboost_system1_66_0-1.66.0-3.10 libidn2-0-2.0.4-1.23 libksba8-1.3.5-2.14 libzio1-1.06-2.20 libproxy1-0.4.15-2.15 libcrack2-2.9.6-2.21 libsemanage1-2.6-1.141 libebl-plugins-0.168-2.164 grep-3.1-2.20 diffutils-3.6-2.11 libelf1-0.168-2.164 libgcrypt20-1.8.2-6.6.1 libp11-kit0-0.23.2-4.2.1 libudev1-234-24.25.1 krb5-1.15.2-6.6.2 libsystemd0-234-24.25.1 libssh4-0.7.5-6.3.1 libcurl4-7.60.0-3.17.1 libaugeas0-1.10.1-1.11 coreutils-8.29-2.12 libprocps6-3.3.12-5.16 sles-release-15-113.3 rpm-4.14.1-10.16.1 pam-1.3.0-6.6.1 shadow-4.5-7.3.1 zypper-1.14.12-3.13.1 system-group-hardware-20170617-4.155 util-linux-2.31.1-9.3.1 netcfg-11.6-1.11 openssl-1_1-1.1.0i-4.21.1 p11-kit-0.23.2-4.2.1 openssl-1.1.0i-3.3.1 ca-certificates-mozilla-2.30-4.9.1 vim
 #zypper -c ${zypp_config} --installroot=${target} clean all



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
