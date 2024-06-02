connect sys/system2@seed as sysdba

Prompt creando usuario admin root

create user c##cdb_admin identified by cdb_admin container=all;


prompt otorgando permisos a usuario viajes
connect sys/system2@pdb_viajes as sysdba

grant create session, create table, create procedure, create sequence to admin_viajes;
alter user admin_viajes quota unlimited on viajes_idx_tbs;
alter user admin_viajes quota unlimited on viajes_big_tbs;

prompt otorgando permisos a  usuario almacen
connect sys/system2@pdb_almacen as sysdba
grant create session, create table, create procedure, create sequence to admin_almacen;
alter user admin_almacen quota unlimited on almacen_idx_tbs;
alter user admin_almacen quota unlimited on almacen_big_tbs;

prompt otorgando permisos a usuario ventas
connect sys/system2@pdb_ventas as sysdba
grant create session, create table, create procedure, create sequence to admin_ventas;
alter user admin_ventas quota unlimited on ventas_idx_tbs;
alter user admin_ventas quota unlimited on ventas_multiple_tbs;

prompt otorgando permisos a usuario centro
connect sys/system2@pdb_centro as sysdba
grant create session, create table, create procedure, create sequence to admin_centro;
alter user admin_centro quota unlimited on centro_idx_tbs;
alter user admin_centro quota unlimited on centro_tbs;