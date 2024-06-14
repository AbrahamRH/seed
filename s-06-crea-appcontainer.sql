conn sys/system2 as sysdba

Prompt creando app container
create pluggable database centro_acopio_con  as application container
    admin user admin_centro identified by admin_centro
    path_prefix='/unam-diplomado-bd/seed/d10/app/oracle/oradata/SEED/'
    file_name_convert = ('/u01/app/oracle/oradata/SEED/pdbseed/',
                            '/unam-diplomado-bd/seed/d10/app/oracle/oradata/SEED/');

alter pluggable database centro_acopio_con open;
alter session set container = centro_acopio_con;

Prompt "Creando PDB de viajes"
create pluggable database pdb_viajes
    admin user admin_viajes identified by admin_viajes
        file_name_convert = ('/u01/app/oracle/oradata/SEED/pdbseed/',
                             '/unam-diplomado-bd/seed/d10/app/oracle/oradata/SEED/viajes');

Prompt "Creando PDB de almacen"
create pluggable database pdb_almacen
    admin user admin_almacen identified by admin_almacen
    file_name_convert = ('/u01/app/oracle/oradata/SEED/pdbseed/',
                            '/unam-diplomado-bd/seed/d10/app/oracle/oradata/SEED/almacen');


alter pluggable database application centro_acopio_app begin install '1.0';

create tablespace centro_idx_tbs
datafile '/unam-diplomado-bd/seed/d10/app/oracle/oradata/SEED/app/idx_centro_tbs.dbf' size 10m
extent management local autoallocate
segment space management auto;

create tablespace centro_tbs
    datafile '/unam-diplomado-bd/seed/d10/app/oracle/oradata/SEED/app/centro_tbs.dbf' size 10m
extent management local autoallocate
segment space management auto;

create user admin_centro_app identified by admin_centro_app
    default tablespace centro_tbs
    quota unlimited on centro_tbs
    container = all;

grant create session, create table, create procedure, create sequence to admin_centro_app;
alter user admin_centro_app quota unlimited on centro_idx_tbs;

prompt tabla: centro_acopio

CREATE TABLE admin_centro_app.CENTRO_ACOPIO sharing=data
(
	centro_acopio_id     INTEGER NOT NULL ,
	nombre_centro        VARCHAR2(30) NOT NULL ,
	direccion_centro     VARCHAR2(1000) NOT NULL ,
	latitud_centro       NUMBER(9,6) NOT NULL ,
	longitud_centro      NUMBER(9,6) NOT NULL ,
	empleado_id          INTEGER NOT NULL 
) tablespace centro_tbs;

prompt indice: centro_acopio_id

CREATE UNIQUE INDEX admin_centro_app.XPKCENTRO_ACOPIO ON admin_centro_app.CENTRO_ACOPIO
(centro_acopio_id   ASC) tablespace centro_idx_tbs;


ALTER TABLE admin_centro_app.CENTRO_ACOPIO
	ADD CONSTRAINT  XPKCENTRO_ACOPIO PRIMARY KEY (centro_acopio_id);


INSERT INTO admin_centro_app.centro_acopio (centro_acopio_id, nombre_centro, direccion_centro, latitud_centro, longitud_centro, empleado_id)
VALUES 
(1, 'Centro A', 'Calle José González 563, Benito Juárez, 83110 Hermosillo, Son.', 29.12345, -110.98765, 21);
INSERT INTO admin_centro_app.centro_acopio (centro_acopio_id, nombre_centro, direccion_centro, latitud_centro, longitud_centro, empleado_id)
VALUES 
(2, 'Centro B', 'Pitiquito, Sonora.', 30.23456, -111.87654, 22);
INSERT INTO admin_centro_app.centro_acopio (centro_acopio_id, nombre_centro, direccion_centro, latitud_centro, longitud_centro, empleado_id)
VALUES 
(3, 'Centro C', 'Puerto Peñasco, Sonora.', 31.34567, -112.76543, 23);
INSERT INTO admin_centro_app.centro_acopio (centro_acopio_id, nombre_centro, direccion_centro, latitud_centro, longitud_centro, empleado_id)
VALUES 
(4, 'Centro D', 'Dirección de Centro D', 32.45678, -113.65432, 24);
INSERT INTO admin_centro_app.centro_acopio (centro_acopio_id, nombre_centro, direccion_centro, latitud_centro, longitud_centro, empleado_id)
VALUES 
(5, 'Centro E', 'HF94+5P3 Jaraguay, Baja California', 29.56789, -114.54321, 25);
INSERT INTO admin_centro_app.centro_acopio (centro_acopio_id, nombre_centro, direccion_centro, latitud_centro, longitud_centro, empleado_id)
VALUES 
(6, 'Centro F', 'San Pedro, Coah.', 26.386310, -102.673854, 26);

alter pluggable database application centro_acopio_app end install;

disconnect