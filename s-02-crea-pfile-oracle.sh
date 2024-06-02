#! /bin/sh

echo "1. Creando un archivo de parámetros básico"

export ORACLE_SID=seed

pfile=$ORACLE_HOME/dbs/init${ORACLE_SID}.ora

if [ -f "${pfile}" ]; then
	read -p "El archivo ${pfile} ya existe, [enter] para sobrescribir"
fi;

echo \
"db_name='${ORACLE_SID}'
db_domain='fi.unam'
memory_target=1024M
enable_pluggable_database=true
control_files=(
		/unam-diplomado-bd/seed/d01/app/oracle/oradata/${ORACLE_SID^^}/control01.ctl,
		/unam-diplomado-bd/seed/d02/app/oracle/oradata/${ORACLE_SID^^}/control02.ctl,
		/unam-diplomado-bd/seed/d03/app/oracle/oradata/${ORACLE_SID^^}/control03.ctl)
" >$pfile

echo "Listo"
echo "Comprobando la existencia y contenido del PFILE"
echo ""
cat ${pfile}