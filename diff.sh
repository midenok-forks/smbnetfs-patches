#!/bin/sh
diff -Nurpd \
    -x '*debian*' \
    -x '*.m4' \
    -x '*autom4te.cache*' \
    -x '*.log' \
    -x '*.status' \
    -x 'configure' \
    -x '*.in' \
    -x changelog \
    -x Makefile \
    -x '.*' \
    -x '*.kdev*' \
    -x Doxyfile \
    -x tags \
    smbnetfs-0.5.3a smbnetfs-0.5.3a-m |
    grep -v '^Binary files'|
    grep -v '^Only in '
