#!/bin/sh
# this script must be run from sgdb

export LD_LIBRARY_PATH=/home/midenok/src/samba-3.6.3/source3/bin
mountpoint=/home/midenok/tmp/mnt2
config=/home/midenok/src/smbnetfs/smbnetfs.conf

optstring_long="config:,mountpoint:,no-ls,host:,progdir:"
optstring_short="c:m:h:"

TEMP=$(getopt -o "${optstring_short}" --long "${optstring_long}" --name 'gdb.sh' -- "$@")
if [ $? != 0 ] ; then echo "Terminating..." >&2 ; exit 1 ; fi
eval set -- "$TEMP"

ls=$mountpoint/hamster
progdir="smbnetfs-0.5.3a"

while true
do
    case "$1" in
        -c|--config)
            config=$2
            shift 2;;
        -m|--mountpoint)
            mountpoint=$2
            shift 2;;
        -h|--host)
            ls=$mountpoint/$2
            shift 2;;
        --progdir)
            progdir=$2
            shift 2;;
        --no-ls)
            unset ls
            shift;;
         --) shift; break;;
    esac
done

args="${progdir}/src/smbnetfs ${mountpoint} -d -o config=${config}"


at_background()
{
    if [ -n "$ls" ]
    then
        sleep 1
        ls $ls &> /dev/null
    fi
}

at_exit()
{
    sudo umount -l ${mountpoint}
}
