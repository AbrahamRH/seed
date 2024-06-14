backup as backupset database tag bk_set format '/unam-diplomado-bd/seed/d11/app/oracle/oradata/SEED/%u_%p_%c';
backup as backupset database tag bk_set_fra;
backup as copy device type disk database tag bk_copy;
backup as copy device type disk database tag bk_copy fotmat '/unam-diplomado-bd/seed/d11/app/oracle/oradata/SEED/data-D-%d-id-%I_TS-%N_FNO-%f_%u'
backup as backupset incremental level 0 database tag bk_level_0;
backup as backupset incremental level 1 database tag bk_level_1;
backup database plus archivelog;