update nyec_etl_process_app 
set
 COMPLETE_DT	= to_date( '3/18/2014 12:47:36 PM','mm/dd/yyyy hh:mi:ss am')
,CANCEL_DATE	=  to_date( '3/18/2014 12:47:36 PM','mm/dd/yyyy hh:mi:ss am')
,APP_STATUS	= 'Completed(Withdrawn)'
,APP_STATUS_GROUP	= 'Cancelled' 
,CANCEL_FLAG	= 'Y' 
,INSTANCE_STATUS	= 'Complete' 
,INSTANCE_COMPLETE_DT	= to_date( '3/18/2014 12:47:36 PM','mm/dd/yyyy hh:mi:ss am')
,CURRENT_TASK_ID	= NULL 
,STAGE_DONE_DATE	= to_date( '3/18/2014 12:47:36 PM','mm/dd/yyyy hh:mi:ss am')
where cepa_id = 586217;

update process_app_stg
   set app_priority_ind = 0
     , APP_EXTRACT_COMPLETE_DT =  to_date( '3/18/2014 12:47:36 PM','mm/dd/yyyy hh:mi:ss am')
where app_id = 691525
  and reactivation_nbr = 0;
  
commit;  