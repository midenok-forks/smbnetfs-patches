set detach-on-fork on
set follow-fork-mode parent

b process_start_new_smb_conn
run
c
set follow-fork-mode child
b smb_conn_process_fd_query
c


