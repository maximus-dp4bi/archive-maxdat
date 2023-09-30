alter session set current_schema = MAXDAT;
---- NYHIX-59229

select 'Before corp_etl_mfb_batch_stg', batch_id, batch_name, reprocessed_flag from CORP_ETL_MFB_BATCH_STG  where batch_name IN ('NYSOH_FAX-HRA2020-06-30-13-17-39-746');
update CORP_ETL_MFB_BATCH_STG set reprocessed_flag = 'Y'  where batch_name IN ('NYSOH_FAX-HRA2020-06-30-13-17-39-746');
commit;
select 'After corp_etl_mfb_batch_stg', batch_id, batch_name, reprocessed_flag from CORP_ETL_MFB_BATCH_STG  where batch_name IN ('NYSOH_FAX-HRA2020-06-30-13-17-39-746');
------------
select 'Before corp_etl_mfb_batch', batch_id, batch_name, reprocessed_flag from corp_etl_mfb_batch where batch_name IN ('NYSOH_FAX-HRA2020-06-30-13-17-39-746');
update corp_etl_mfb_batch set reprocessed_flag = 'Y'  where batch_name IN ('NYSOH_FAX-HRA2020-06-30-13-17-39-746');
commit;
select 'After corp_etl_mfb_batch', batch_id, batch_name, reprocessed_flag from corp_etl_mfb_batch where batch_name IN ('NYSOH_FAX-HRA2020-06-30-13-17-39-746');




