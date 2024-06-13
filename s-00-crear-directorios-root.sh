#! /bin/sh

export ORACLE_SID=seed
root=/unam-diplomado-bd/seed

echo "Creando carpet raiz del proyecto"

echo "Creando discos"
mkdir -p ${root}/d01
mkdir -p ${root}/d02
mkdir -p ${root}/d03
mkdir -p ${root}/d04
mkdir -p ${root}/d05
mkdir -p ${root}/d06
mkdir -p ${root}/d07
mkdir -p ${root}/d08
mkdir -p ${root}/d09
mkdir -p ${root}/d10
mkdir -p ${root}/d11

echo "Creando directorios para datafiles"
mkdir -p /u01/app/oracle/oradata/${ORACLE_SID^^}/pdbseed
chown oracle:oinstall /u01/app/oracle/oradata/${ORACLE_SID^^} -R
chmod 750 /u01/app/oracle/oradata/${ORACLE_SID^^} -R
echo "Comprobando la creacion en oradata"
ls -l  /u01/app/oracle/oradata/${ORACLE_SID^^}/pdbseed

echo "Creando subdirectorios"
cd ${root}
mkdir -p d01/app/oracle/oradata/${ORACLE_SID^^}
mkdir -p d02/app/oracle/oradata/${ORACLE_SID^^}
mkdir -p d03/app/oracle/oradata/${ORACLE_SID^^}
mkdir -p d04/app/oracle/oradata/${ORACLE_SID^^}
mkdir -p d05/app/oracle/oradata/${ORACLE_SID^^}
mkdir -p d06/app/oracle/oradata/${ORACLE_SID^^}/FRA
mkdir -p d07/app/oracle/oradata/${ORACLE_SID^^}
mkdir -p d08/app/oracle/oradata/${ORACLE_SID^^}
mkdir -p d09/app/oracle/oradata/${ORACLE_SID^^}
mkdir -p d10/app/oracle/oradata/${ORACLE_SID^^}/app
mkdir -p d10/app/oracle/oradata/${ORACLE_SID^^}/viajes
mkdir -p d10/app/oracle/oradata/${ORACLE_SID^^}/almacen
mkdir -p d11/app/oracle/oradata/${ORACLE_SID^^}

echo "cambiando de dueño a los discos"
chown -R oracle:oinstall d01/app
chown -R oracle:oinstall d02/app
chown -R oracle:oinstall d03/app
chown -R oracle:oinstall d04/app
chown -R oracle:oinstall d05/app
chown -R oracle:oinstall d06/app
chown -R oracle:oinstall d07/app
chown -R oracle:oinstall d08/app
chown -R oracle:oinstall d09/app
chown -R oracle:oinstall d10/app
chown -R oracle:oinstall d11/app

echo "cambiando permisos"
chmod -R 750 d01/app
chmod -R 750 d02/app
chmod -R 750 d03/app
chmod -R 750 d04/app
chmod -R 750 d05/app
chmod -R 750 d06/app
chmod -R 750 d07/app
chmod -R 750 d08/app
chmod -R 750 d09/app
chmod -R 750 d10/app
chmod -R 750 d11/app

echo "Mostrando directorio de data files"
ls -l /u01/app/oracle/oradata

echo "Mostrando directorios para control files y redo logs"
ls -l ${root}/d0*/app/oracle/oradata