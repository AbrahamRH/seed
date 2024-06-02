
Pause Conectarse al ORACLE_SID=seed, [ENTER] para continuar


Prompt Connectando como sys
connect sys/hola1234* as sysdba
Prompt Iniciando la instancia como nomount
startup nomount
Prompt Creando base de datos

whenever sqlerror exit rollback;

create database seed
user sys identified by system2
user system identified by system2
logfile group 1 (
'/unam-diplomado-bd/seed/d01/app/oracle/oradata/SEED/redo01a.log',
'/unam-diplomado-bd/seed/d02/app/oracle/oradata/SEED/redo01b.log',
'/unam-diplomado-bd/seed/d03/app/oracle/oradata/SEED/redo01c.log') size 50m blocksize 512,
group 2 (
'/unam-diplomado-bd/seed/d01/app/oracle/oradata/SEED/redo02a.log',
'/unam-diplomado-bd/seed/d02/app/oracle/oradata/SEED/redo02b.log',
'/unam-diplomado-bd/seed/d03/app/oracle/oradata/SEED/redo02c.log') size 50m blocksize 512,
group 3 (
'/unam-diplomado-bd/seed/d01/app/oracle/oradata/SEED/redo03a.log',
'/unam-diplomado-bd/seed/d02/app/oracle/oradata/SEED/redo03b.log',
'/unam-diplomado-bd/seed/d03/app/oracle/oradata/SEED/redo03c.log') size 50m blocksize 512
maxloghistory 1
maxlogfiles 16
maxlogmembers 3
maxdatafiles 1024
character set AL32UTF8
national character set AL16UTF16
extent management local
datafile '/u01/app/oracle/oradata/SEED/system01.dbf'
size 700m reuse autoextend on next 10240k maxsize unlimited
sysaux datafile '/u01/app/oracle/oradata/SEED/sysaux01.dbf'
size 550m reuse autoextend on next 10240k maxsize unlimited
default tablespace users
datafile '/u01/app/oracle/oradata/SEED/users01.dbf'
size 500m reuse autoextend on maxsize unlimited
default temporary tablespace tempts1
tempfile '/u01/app/oracle/oradata/SEED/temp01.dbf'
size 20m reuse autoextend on next 640k maxsize unlimited
undo tablespace undotbs1
datafile '/u01/app/oracle/oradata/SEED/undotbs01.dbf'
size 200m reuse autoextend on next 5120k maxsize unlimited
enable pluggable database
seed file_name_convert =
    ('/u01/app/oracle/oradata/SEED/system01.dbf','/u01/app/oracle/oradata/SEED/pdbseed/system01.dbf',
    '/u01/app/oracle/oradata/SEED/sysaux01.dbf','/u01/app/oracle/oradata/SEED/pdbseed/sysaux01.dbf',
    '/u01/app/oracle/oradata/SEED/users01.dbf','/u01/app/oracle/oradata/SEED/pdbseed/users01.dbf',
    '/u01/app/oracle/oradata/SEED/temp01.dbf','/u01/app/oracle/oradata/SEED/pdbseed/temp01.dbf',
    '/u01/app/oracle/oradata/SEED/undotbs01.dbf','/u01/app/oracle/oradata/SEED/pdbseed/undotbs01.dbf');

Prompt cambiando contraseñas a los usuarios
alter user sys identified by system2;
alter user system identified by system2;
alter user sysbackup identified by system2;