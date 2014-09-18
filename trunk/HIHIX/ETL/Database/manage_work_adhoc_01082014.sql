delete from bpm_instance_attribute where bi_id in (select bi_id from bpm_instance where bem_id = 1 and Identifier in ('2129', '2972', '5862') );
delete from bpm_update_event where bi_id in (select bi_id from bpm_instance where bem_id = 1 and Identifier in ('2129', '2972', '5862') );
delete from bpm_instance where bem_id = 1 and Identifier in ('2129', '2972', '5862');

commit; 

delete from corp_etl_manage_work where task_id in ('2129', '2972', '5862') ;

delete from f_mw_by_date where mw_bi_id in (select mw_bi_id  from d_mw_current where "Task ID" in ('2129', '2972', '5862') );

delete from d_mw_current where "Task ID" in ('2129', '2972', '5862');

commit;

 