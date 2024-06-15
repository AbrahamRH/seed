connect sys/system2@seed as sysdba

Prompt creando usuario admin root

create user c##cdb_admin identified by cdb_admin container=all;
grant create session, create table, create procedure, create sequence to admin_viajes;

prompt otorgando permisos a usuario viajes
connect sys/system2@pdb_viajes as sysdba

grant create session, create table, create procedure, create sequence to admin_viajes;
alter user admin_viajes quota unlimited on viajes_idx_tbs;
alter user admin_viajes quota unlimited on viajes_big_tbs;
alter user admin_viajes quota unlimited on viajes_tbs;
alter user admin_viajes default tablespace viajes_tbs;

prompt otorgando permisos a  usuario almacen
connect sys/system2@pdb_almacen as sysdba
grant create session, create table, create procedure, create sequence to admin_almacen;
alter user admin_almacen quota unlimited on almacen_idx_tbs;
alter user admin_almacen quota unlimited on almacen_big_tbs;
alter user admin_almacen quota unlimited on almacen_tbs;
alter user admin_almacen default tablespace almacen_tbs;

prompt otorgando permisos a usuario ventas
connect sys/system2@pdb_ventas as sysdba
grant create session, create table, create procedure, create sequence to admin_ventas;
alter user admin_ventas quota unlimited on ventas_idx_tbs;
alter user admin_ventas quota unlimited on ventas_multiple_tbs;
alter user admin_ventas quota unlimited on ventas_tbs;

disconnect