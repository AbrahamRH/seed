connect sys/system2 as sysdba
@?/rdbms/admin/catalog.sql
@?/rdbms/admin/catproc.sql
@?/rdbms/admin/utlrp.sql

connect system/system2
@?/sqlplus/admin/pupbld.sql

connect sys/system2 as sysdba
@?/rdbms/admin/catcdb.sql