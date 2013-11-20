set detach-on-fork on
set follow-fork-mode parent

b smb_conn_opendir
run
c
# process.c:153


