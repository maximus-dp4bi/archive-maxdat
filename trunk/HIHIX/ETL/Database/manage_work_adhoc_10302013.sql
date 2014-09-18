update corp_etl_manage_work 
   set Complete_date =  to_date('01-OCT-2013','DD-MON-YYYY')
      , Status_date =  to_date('01-OCT-2013','DD-MON-YYYY')
where task_id in (272);

update corp_etl_manage_work 
   set Complete_date =  to_date('03-OCT-2013','DD-MON-YYYY')
      , Status_date =  to_date('03-OCT-2013','DD-MON-YYYY')
      , Create_date =  to_date('01-OCT-2013','DD-MON-YYYY')
where task_id in (278,280,294,118);

update corp_etl_manage_work 
   set Complete_date =  to_date('04-OCT-2013','DD-MON-YYYY')
      , Status_date =  to_date('04-OCT-2013','DD-MON-YYYY')
      , Create_date =  to_date('02-OCT-2013','DD-MON-YYYY')      
where task_id in (299,300,296,297,298,293,811);

update corp_etl_manage_work 
   set Complete_date =  to_date('05-OCT-2013','DD-MON-YYYY')
      , Status_date =  to_date('05-OCT-2013','DD-MON-YYYY')
      , Create_date =  to_date('02-OCT-2013','DD-MON-YYYY')            
where task_id in (292);

update corp_etl_manage_work 
   set Complete_date =  to_date('05-OCT-2013','DD-MON-YYYY')
      , Status_date =  to_date('05-OCT-2013','DD-MON-YYYY')
      , Create_date =  to_date('05-OCT-2013','DD-MON-YYYY')            
where task_id in (695,271);

update corp_etl_manage_work 
   set Complete_date =  to_date('10-OCT-2013','DD-MON-YYYY')
      , Status_date =  to_date('10-OCT-2013','DD-MON-YYYY')
      , Create_date =  to_date('10-OCT-2013','DD-MON-YYYY')       
where task_id in (737);

update corp_etl_manage_work 
  set unit_of_work = 'Outbound Web Chat'
where Task_Type = 'Outbound Web Chat Other'
 and unit_of_work is null;

update corp_etl_manage_work 
  set unit_of_work = 'Voicemail'
where Task_Type = 'Voicemail'
 and unit_of_work is null;

update corp_etl_manage_work 
  set unit_of_work = 'Incoming Email'
where Task_Type = 'Incoming email other'
 and unit_of_work is null;
   
commit;   