update corp_etl_mfb_batch set batch_complete_dt=sysdate,stg_last_update_date=sysdate,current_batch_module_id='N/A' where batch_guid in(select batch_guid from corp_etl_mfb_batch_stg
where stg_insert_job_id=3);
commit;
