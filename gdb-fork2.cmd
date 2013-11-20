set detach-on-fork on
set follow-fork-mode parent

b process_start_new_smb_conn
run
c
# process.c:153


