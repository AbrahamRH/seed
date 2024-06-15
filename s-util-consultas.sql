set linesize window

-- mostrar usuarios de las pdbs
col pdb_name format a20
col username format a20
select u.username, p.con_id, p.pdb_name, u.created 
    from cdb_users u, dba_pdbs p 
    where p.pdb_id=u.con_id 
    and username like 'ADMIN%';


-- Consulta de la ubicacion de los datafiles
col pdb_name format a20
col tablespace_name format a20
col file_name format a80
select p.pdb_id, p.pdb_name, d.file_id, d.tablespace_name, d.file_name
    from dba_pdbs p, cdb_data_files d
    where p.pdb_id = d.con_id
    order by p.pdb_id;

-- Consulta de la informacion para los redologs
col member format a80
select group#, type, member from v$logfile;
select * from v$log;

-- Consulta informacion de archive logs
select name, dest_id,  blocks from v$archived_log;

-- Uso de la FRA
col name format a20
select * from v$recovery_file_dest;
SELECT * FROM V$RECOVERY_AREA_USAGE;


-- Consulta el nombre del app container
SELECT app_name,
       app_version,
       app_status
FROM   dba_applications
WHERE  app_name = 'CENTRO_ACOPIO_APP';

-- Consulta backups
set linesize 500
col backup_size for a20
SELECT input_type "backup_type", status,
    output_bytes_display "backup_size",
    output_device_type "output_device"
from V$RMAN_BACKUP_JOB_DETAILS
where start_time > sysdate-15
order by end_time desc;


-- Tamaño de la base de datos, espacio usado y espacio libre 
SELECT ROUND(SUM(USED.BYTES) / 1024 / 1024 / 1024 ) "DATABASE SIZE IN GB",
        ROUND(SUM(USED.BYTES) / 1024 / 1024 / 1024 ) - ROUND(FREE.P / 1024 / 1024 / 1024) "USED SPACE IN GB",
        ROUND(FREE.P / 1024 / 1024 / 1024) "FREE SPACE IN GB"
FROM (
      SELECT BYTES FROM V$DATAFILE
      UNION ALL
      SELECT BYTES FROM V$TEMPFILE
      UNION ALL
      SELECT BYTES FROM V$LOG
      ) USED,
      (SELECT SUM(BYTES) AS P
      FROM DBA_FREE_SPACE) FREE 
GROUP BY FREE.P;