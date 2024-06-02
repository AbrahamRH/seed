connect sys/system2 as sysdba

alter system set log_archive_max_processes = 2 scope = spfile;
alter system set log_archive_dest_1 = 'LOCATION=/unam-diplomado-bd/seed/d04/app/oracle/oradata/SEED MANDATORY' scope = spfile;
alter system set log_archive_dest_2 = 'LOCATION=/unam-diplomado-bd/seed/d05/app/oracle/oradata/SEED' scope = spfile;
alter system set log_archive_dest_3 = 'LOCATION=USE_DB_RECOVERY_FILE_DEST' scope = spfile;
alter system set log_archive_format = 'arch_seed_%t_%s_%r.arc' scope = spfile;
alter system set log_archive_min_succeed_dest = 1 scope = spfile;

shutdown
startup mount
alter database archivelog;
alter database open;
archive log list