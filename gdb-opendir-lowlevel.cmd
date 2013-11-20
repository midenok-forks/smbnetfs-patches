set detach-on-fork on
set follow-fork-mode parent

b smb_conn_opendir
run
c
b smb_conn_process_query_lowlevel_va
c
# process.c:153


