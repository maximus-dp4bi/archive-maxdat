update corp_etl_mfb_batch set batch_complete_dt=to_date('13-JUN-2016 15:00:00','DD-MON-YYYY HH24:MI:SS'),stg_last_update_date=sysdate,current_batch_module_id='N/A',instance_status='Complete'
where batch_complete_dt is null and instance_status='Active'
and batch_name in('389528-6/10/2016-2:49:34 PM-86863',
'389535-6/10/2016-2:54:10 PM-116630');
commit;
