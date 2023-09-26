ALTER TABLE CORP_ETL_PROC_LETTERS DISABLE ALL TRIGGERS;

ALTER TABLE CORP_ETL_PROC_LETTERS_OLTP DISABLE ALL TRIGGERS;

ALTER TABLE CORP_ETL_PROC_LETTERS_WIP_BPM DISABLE ALL TRIGGERS;

ALTER TABLE CORP_ETL_PROC_LETTERS drop column MEDIA_CD ;

ALTER TABLE CORP_ETL_PROC_LETTERS_OLTP drop column MEDIA_CD ;

ALTER TABLE CORP_ETL_PROC_LETTERS_WIP_BPM drop column MEDIA_CD ;

ALTER TABLE D_PL_CURRENT drop column MEDIA_CD ;

ALTER TABLE CORP_ETL_PROC_LETTERS ENABLE ALL TRIGGERS;

ALTER TABLE CORP_ETL_PROC_LETTERS_OLTP ENABLE ALL TRIGGERS;

ALTER TABLE CORP_ETL_PROC_LETTERS_WIP_BPM ENABLE ALL TRIGGERS;

COMMIT;