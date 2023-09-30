update corp_etl_manage_work 
   set Complete_date =  to_date('02-NOV-2013','DD-MON-YYYY')
      , Status_date =  to_date('02-NOV-2013','DD-MON-YYYY')
where task_id in (2522,2523,2556)
  and complete_date <>  to_date('02-NOV-2013','DD-MON-YYYY');

commit;

delete from bpm_instance_attribute where bi_id in (select bi_id from bpm_instance where bem_id = 1 and Identifier = '2333');
delete from bpm_update_event where bi_id in (select bi_id from bpm_instance where bem_id = 1 and Identifier = '2333');
delete from bpm_instance where bem_id = 1 and Identifier = '2333';

commit; 

delete from corp_etl_manage_work where task_id = 2333;

delete from f_mw_by_date where mw_bi_id in (select mw_bi_id  from d_mw_current where "Task ID" = 2333);

delete from d_mw_current where "Task ID" = 2333;

commit;