#!/bin/bash

unset sgdb_opts
unset shell_opts

push_back()
{
    arr=$1; shift
    for val in "$@"
    do
        eval $arr[\${#$arr[@]}]=\$val
    done
}


while [ -n "${1/#-*/}" ]
do
    if [ -z "${1/%*.cmd/}" ]
    then
        push_back sgdb_opts -x "$1"
    else
        if [ -d "$1" ]
        then
            push_back shell_opts --progdir "$1"
        elif [ -d "smbnetfs-0.5.3a-$1" ]
        then
            push_back shell_opts --progdir "smbnetfs-0.5.3a-${1}"
        else
            echo "Unrecognized word: $1" >&2
            exit 1
        fi
    fi
    shift
done

optstring_long="config:,mountpoint:,no-ls,host:,progdir:"
optstring_short="c:m:h:"
optstring_long="${optstring_long}args:,command:,no-command,no-gdb,strace,verbose"
optstring_short="${optstring_short}x:ntv"

TEMP=$(getopt -o "${optstring_short}" --long "${optstring_long}" --name 'run.sh' -- "$@")
if [ $? != 0 ] ; then echo "Terminating..." >&2 ; exit 1 ; fi
eval set -- "$TEMP"

while true
do
    case "$1" in
        -c|--config|-m|--mountpoint|-h|--host|--progdir)
            push_back shell_opts $1 $2
            shift 2;;
        --no-ls)
            push_back shell_opts $1
            shift;;
        --args|-x|--command)
            push_back sgdb_opts $1 $2
            shift 2;;
        --no-command|-n|--no-gdb|-t|--strace|--verbose|-v)
            push_back sgdb_opts $1
            shift;;
         --) shift; break;;
    esac
done


sgdb "${sgdb_opts[@]}" -- "${shell_opts[@]}" -- "$@"
