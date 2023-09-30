BEGIN
   
update process_app_Stg set app_priority_ind = 1 
 where app_id in 
(select app_id
  from nyec_etl_process_app a
 where stage_done_date is null
   and asf_cancel_app = 'N'
   and cancel_date is not null );

update nyec_etl_process_app set asf_cancel_app = 'Y' 
 where stage_done_date is null
   and asf_cancel_app = 'N'
   and cancel_date is not null;

COMMIT;

END;   
/