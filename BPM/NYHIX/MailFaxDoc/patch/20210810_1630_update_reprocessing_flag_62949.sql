alter session set current_schema = MAXDAT;
---- NYHIX-62035
update CORP_ETL_MFB_BATCH_STG set reprocessed_flag = 'Y' where BATCH_NAME = 'NYHO-FAX-FPBP-2021-07-20-11-40-12-267';
commit;
update corp_etl_mfb_batch set reprocessed_flag = 'Y' where BATCH_NAME = 'NYHO-FAX-FPBP-2021-07-20-11-40-12-267';
commit;
