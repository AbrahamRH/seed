conn sys/system2 as sysdba

Prompt creando app container
create pluggable database centro_acopio_con  as application container
    admin user admin_centro_con identified by admin_centro_con
    path_prefix='/unam-diplomado-bd/seed/d10/app/oracle/oradata/SEED/'
    file_name_convert = ('/u01/app/oracle/oradata/SEED/pdbseed/',
                            '/unam-diplomado-bd/seed/d10/app/oracle/oradata/SEED/');

alter pluggable database centro_acopio_con open;
alter session set container = centro_acopio_con;

Prompt creando pdb_centro
create pluggable database pdb_centro
    admin user admin_centro identified by admin_centro
    file_name_convert = ('/u01/app/oracle/oradata/SEED/pdbseed/',
                            '/unam-diplomado-bd/seed/d10/app/oracle/oradata/SEED/app');

alter pluggable database pdb_centro open;