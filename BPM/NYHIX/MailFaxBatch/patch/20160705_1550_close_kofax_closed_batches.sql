update corp_etl_mfb_batch 
set batch_complete_dt=to_date('24-JUN-2016 09:21:55','DD-MON-YYYY HH24:MI:SS')
,stg_last_update_date=sysdate
,current_batch_module_id='N/A'
,instance_status='Complete'
,instance_status_dt = to_date('24-JUN-2016 09:21:55','DD-MON-YYYY HH24:MI:SS')
,ased_release_dms = to_date('24-JUN-2016 09:21:55','DD-MON-YYYY HH24:MI:SS')
,complete_dt=to_date('24-JUN-2016 09:21:55','DD-MON-YYYY HH24:MI:SS')
,current_step='End - Release to DMS'
where batch_name = '393409-6/23/2016-9:59:29 AM-116630';
commit;
