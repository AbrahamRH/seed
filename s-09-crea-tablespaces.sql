conn sys/system2 as sysdba


Prompt abriendo pdbs
alter pluggable database pdb_ventas open;
alter pluggable database pdb_almacen open;
alter pluggable database pdb_viajes open;
alter pluggable database centro_acopio_con open;

alter session set container=centro_acopio_con;
alter pluggable database pdb_centro open;

Prompt creando tablespaces de pdb_viajes
alter session set container=pdb_viajes;
create tablespace viajes_idx_tbs
datafile '/unam-diplomado-bd/seed/d07/app/oracle/oradata/SEED/idx_viajes_tbs.dbf' size 10m
extent management local autoallocate
segment space management auto;

create tablespace viajes_big_tbs
datafile '/unam-diplomado-bd/seed/d07/app/oracle/oradata/SEED/viajes_big_tbs.dbf' size 100m
extent management local autoallocate
segment space management auto;

Prompt creando tablespaces de pdb_almacen
alter session set container=pdb_almacen;

create tablespace almacen_idx_tbs
datafile '/unam-diplomado-bd/seed/d08/app/oracle/oradata/SEED/idx_almacen_tbs.dbf' size 10m
extent management local autoallocate
segment space management auto;

create tablespace almacen_big_tbs
datafile '/unam-diplomado-bd/seed/d08/app/oracle/oradata/SEED/almacen_big_tbs.dbf' size 100m
extent management local autoallocate
segment space management auto;


Prompt creando tablespaces de pdb_ventas
alter session set container=pdb_ventas;

create tablespace ventas_idx_tbs
datafile '/unam-diplomado-bd/seed/d09/app/oracle/oradata/SEED/idx_ventas_tbs.dbf' size 10m
extent management local autoallocate
segment space management auto;

create tablespace ventas_multiple_tbs
datafile '/unam-diplomado-bd/seed/d09/app/oracle/oradata/SEED/ventas_multiple_tbs01.dbf' size 10m,
         '/unam-diplomado-bd/seed/d05/app/oracle/oradata/SEED/ventas_multiple_tbs02.dbf' size 10m,
         '/unam-diplomado-bd/seed/d06/app/oracle/oradata/SEED/ventas_multiple_tbs03.dbf' size 10m
extent management local autoallocate
segment space management auto;


Prompt creando tablespaces para pdb_centro
alter session set container=pdb_centro;

create tablespace centro_idx_tbs
datafile '/unam-diplomado-bd/seed/d10/app/oracle/oradata/SEED/idx_centro_tbs.dbf' size 10m
extent management local autoallocate
segment space management auto;

create tablespace centro_tbs
    datafile '/unam-diplomado-bd/seed/d10/app/oracle/oradata/SEED/centro_tbs.dbf' size 10m
extent management local autoallocate
segment space management auto;

conn sys/system2 as sysdba