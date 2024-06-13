connect sys/system2 as sysdba


Prompt "Creando PDB de ventas"
create pluggable database pdb_ventas
    admin user admin_ventas identified by admin_ventas
    default tablespace ventas_tbs
        datafile '/unam-diplomado-bd/seed/d09/app/oracle/oradata/SEED/ventas_tbs.dbf' size 500m
        autoextend on
        path_prefix='/unam-diplomado-bd/seed/d09/app/oracle/oradata/SEED/'
        file_name_convert = ('/u01/app/oracle/oradata/SEED/pdbseed/',
                             '/unam-diplomado-bd/seed/d09/app/oracle/oradata/SEED/');

