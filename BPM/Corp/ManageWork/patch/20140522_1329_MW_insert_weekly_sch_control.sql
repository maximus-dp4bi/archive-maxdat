-- Installed for NYEC and NYHIX only.

Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION) values ('MW_BATCH_MISMATCH_LAST_UPDATE','D','2014/06/01','Last date the MW Task status mismatch job ran (format YYYY/MM/DD). Initially scheduled every week on Sunday.');
Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION) values ('MW_BATCH_MISMATCH_DAY','V','SAT, SUN','Batch scheduled to run only during the weekend. This control originally set for SAT and SUN.');


COMMIT;
