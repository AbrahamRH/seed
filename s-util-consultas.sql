-- mostrar usuarios de las pdbs
select u.username, p.con_id, p.pdb_name, u.created from cdb_users u, dba_pdbs p where p.pdb_id=u.con_id and username like 'ADMIN%';

-- Uso de la FRA
col name format a20
select * from v$recovery_file_dest;
SELECT * FROM V$RECOVERY_AREA_USAGE;