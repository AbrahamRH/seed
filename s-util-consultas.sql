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

-- Uso de la FRA
col name format a20
select * from v$recovery_file_dest;
SELECT * FROM V$RECOVERY_AREA_USAGE;