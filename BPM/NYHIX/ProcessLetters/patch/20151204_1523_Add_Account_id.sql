ALTER TABLE CORP_ETL_PROC_LETTERS DISABLE ALL TRIGGERS;

ALTER TABLE CORP_ETL_PROC_LETTERS_OLTP DISABLE ALL TRIGGERS;

ALTER TABLE CORP_ETL_PROC_LETTERS_WIP_BPM DISABLE ALL TRIGGERS;

ALTER TABLE CORP_ETL_PROC_LETTERS ADD (ACCOUNT_ID NUMBER(18,0) DEFAULT null) ;

ALTER TABLE CORP_ETL_PROC_LETTERS_OLTP ADD (ACCOUNT_ID NUMBER(18,0) DEFAULT null) ;

ALTER TABLE CORP_ETL_PROC_LETTERS_WIP_BPM ADD (ACCOUNT_ID NUMBER(18,0) DEFAULT null) ;

ALTER TABLE D_PL_CURRENT ADD (ACCOUNT_ID NUMBER(18,0) DEFAULT null) ;

ALTER TABLE CORP_ETL_PROC_LETTERS ENABLE ALL TRIGGERS;

ALTER TABLE CORP_ETL_PROC_LETTERS_OLTP ENABLE ALL TRIGGERS;

ALTER TABLE CORP_ETL_PROC_LETTERS_WIP_BPM ENABLE ALL TRIGGERS;

COMMIT;