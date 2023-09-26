alter session set current_schema = MAXDAT;
----  NYHIX-62381
select 'Before corp_etl_mfb_batch_stg', batch_id, batch_name, reprocessed_flag from CORP_ETL_MFB_BATCH_STG where batch_name IN( 'NYHO-FAX-FPBP-2021-04-28-12-05-19-664');
update CORP_ETL_MFB_BATCH_STG set reprocessed_flag = 'Y'  where batch_name IN( 'NYHO-FAX-FPBP-2021-04-28-12-05-19-664');
commit;
select 'After corp_etl_mfb_batch_stg', batch_id, batch_name, reprocessed_flag  from CORP_ETL_MFB_BATCH_STG  where batch_name IN( 'NYHO-FAX-FPBP-2021-04-28-12-05-19-664');
------------
select 'Before corp_etl_mfb_batch', batch_id, batch_name, reprocessed_flag from corp_etl_mfb_batch  where batch_name IN( 'NYHO-FAX-FPBP-2021-04-28-12-05-19-664');
update corp_etl_mfb_batch set reprocessed_flag = 'Y'   where batch_name IN( 'NYHO-FAX-FPBP-2021-04-28-12-05-19-664');
commit;
select 'After corp_etl_mfb_batch', batch_id, batch_name, reprocessed_flag from corp_etl_mfb_batch  where batch_name IN( 'NYHO-FAX-FPBP-2021-04-28-12-05-19-664');
