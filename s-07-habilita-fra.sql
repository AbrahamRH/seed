
connect sys/system2 as sysdba


alter system set db_recovery_file_dest_size=20g scope=spfile;

alter system set db_recovery_file_dest='/unam-diplomado-bd/seed/d06/app/oracle/oradata/SEED/FRA' scope=spfile;

alter system set db_flashback_retention_target=4320 scope=spfile;

shutdown immediate
startup