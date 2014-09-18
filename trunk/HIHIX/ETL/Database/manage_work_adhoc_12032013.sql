update corp_etl_manage_work 
   set Complete_date =  to_date('21-NOV-2013','DD-MON-YYYY')
      , Status_date =  to_date('21-NOV-2013','DD-MON-YYYY')
where task_id in (3822)
  and complete_date <>  to_date('21-NOV-2013','DD-MON-YYYY');

commit;

