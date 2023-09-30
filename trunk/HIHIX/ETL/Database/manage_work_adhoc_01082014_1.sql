update corp_etl_manage_work 
   set Complete_date =  to_date('31-DEC-2013','DD-MON-YYYY')
      , Status_date =  to_date('31-DEC-2013','DD-MON-YYYY')
where task_id in (6534,6535)
  and complete_date <>  to_date('31-DEC-2013','DD-MON-YYYY');

update corp_etl_manage_work 
   set Complete_date =  to_date('20-DEC-2013','DD-MON-YYYY')
      , Status_date =  to_date('20-DEC-2013','DD-MON-YYYY')
where task_id in (5741)
  and complete_date <>  to_date('20-DEC-2013','DD-MON-YYYY');

update corp_etl_manage_work 
   set Complete_date =  to_date('03-JAN-2014','DD-MON-YYYY')
      , Status_date =  to_date('03-JAN-2014','DD-MON-YYYY')
where task_id in (6867)
  and complete_date <>  to_date('03-JAN-2014','DD-MON-YYYY');


update corp_etl_manage_work 
   set Complete_date =  to_date('02-JAN-2014','DD-MON-YYYY')
      , Status_date =  to_date('02-JAN-2014','DD-MON-YYYY')
where task_id in (6864)
  and complete_date <>  to_date('02-JAN-2014','DD-MON-YYYY');


commit;

