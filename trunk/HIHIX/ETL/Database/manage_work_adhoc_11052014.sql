update corp_etl_manage_work
   set Complete_date =  to_date('18-OCT-2014','DD-MON-YYYY')
      , Status_date  =  to_date('18-OCT-2014','DD-MON-YYYY')
      , Complete_Flag = 'Y'
      , TASK_STATUS = 'COMPLETE'
 where Task_id = 18721;

update corp_etl_manage_work
   set Complete_date =  to_date('28-OCT-2014','DD-MON-YYYY')
      , Status_date  =  to_date('28-OCT-2014','DD-MON-YYYY')
      , Complete_Flag = 'Y'
      , TASK_STATUS = 'COMPLETE'
 where Task_id = 18885;

delete from corp_etl_manage_work 
 where task_id in (18568,18578,18640,18672,18680,18711,18717,18725,18754,18771,
18774,18782,18783,18809,18821,18845,18863,18864,18891,18925,18912,18913,18933,18934,18965) ;

delete from f_mw_by_date where mw_bi_id in 
(select mw_bi_id  from d_mw_current
  where "Task ID" in (18568,18578,18640,18672,18680,18711,18717,18725,18754,18771,
18774,18782,18783,18809,18821,18845,18863,18864,18891,18925,18912,18913,18933,18934,18965) );

delete from d_mw_current where "Task ID" in (18568,18578,18640,18672,18680,18711,18717,18725,18754,18771,
18774,18782,18783,18809,18821,18845,18863,18864,18891,18925,18912,18913,18933,18934,18965);

commit;