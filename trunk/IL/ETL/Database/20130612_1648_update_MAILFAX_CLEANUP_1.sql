update corp_instance_cleanup_table set 
statement = 'UPDATE corp_etl_mailfaxdoc 
  set CANCEL_DT = SYSDATE,
  INSTANCE_COMPLETE_DT = SYSDATE,
  STAGE_DONE_DT = SYSDATE,
  cancel_by = '||'''Cleanup 1'''||',
  instance_status = '||'''Complete'''||' ,
  cancel_method = ''Exception'',
  cancel_reason = ''Document Trashed in Source System without Status'' 
where instance_status = '||'''Active'''||'  
AND   cancel_dt is null                                       
AND   dcn in  (select m.dcn  from corp_etl_mailfaxdoc_oltp o ,corp_etl_mailfaxdoc m  where o.trashed_doc_ind = 1 and o.dcn = m.dcn)'
where system_name = 'PROCESS_MAILFAXDOC'
and CLEANUP_NAME = 'CLEANUP1';

update f_mfdoc_by_date 
set inventory_count = 1,
completion_count = 0
where mfdoc_bi_id in (select bi_id from bpm_instance 
where identifier in (select dcn from corp_etl_mailfaxdoc where cancel_method = 'Exception'
and cancel_by = 'Cleanup 1') ) and completion_count = 1;

update corp_etl_mailfaxdoc set cancel_dt = null, instance_complete_dt = null ,
stage_done_dt = null,cancel_by = null,instance_status = 'Active',cancel_method = null,cancel_reason = null
where cancel_method = 'Exception'
and cancel_by = 'Cleanup 1';


commit;