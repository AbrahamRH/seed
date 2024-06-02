connect sys/system as sysdba

prompt creando spfile from pfile
create spfile from pfile='/u01/app/oracle/product/19.3.0/dbhome_1/dbs/initseed.ora';

prompt reiniciar base de datos
shutdown immediate
startup