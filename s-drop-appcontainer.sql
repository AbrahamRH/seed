conn sys/system2 as sysdba
alter pluggable database all close;
drop pluggable database pdb_almacen including datafiles;
drop pluggable database pdb_viajes including datafiles;
drop pluggable database pdb_ventas including datafiles;
drop pluggable database centro_acopio_con including datafiles;

disconnect