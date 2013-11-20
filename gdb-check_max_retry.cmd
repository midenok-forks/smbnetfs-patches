set detach-on-fork on
set follow-fork-mode parent

b reconfigure_analyse_simple_option
b smb_conn_set_max_retry_count
b smb_conn_get_max_retry_count
run
