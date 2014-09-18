update corp_etl_manage_work 
   set Complete_date =  to_date('03-OCT-2013','DD-MON-YYYY')
      , Status_date =  to_date('03-OCT-2013','DD-MON-YYYY')
 where task_id IN (81,75,125,126,127,107,119,121,122,123,128,131,133,134,135,137,138,145,80,82,87,89,92,93,94,95,96,98,100,101,63);

update corp_etl_manage_work 
   set Complete_date =  to_date('03-OCT-2013','DD-MON-YYYY')
      , Status_date =  to_date('03-OCT-2013','DD-MON-YYYY')
 where task_id IN (104,110,111,118);

Update bpm_instance 
   set End_Date =  to_date('03-OCT-2013','DD-MON-YYYY') 
 where BEM_ID = 1 and BSL_ID = 1 and BIL_ID = 3
   and Source_ID IN (81,75,125,126,127,107,119,121,122,123,128,131,133,134,135,137,138,145,80,82,87,89,92,93,94,95,96,98,100,101,63);
   
Update bpm_instance 
   set End_Date =  to_date('04-OCT-2013','DD-MON-YYYY') 
 where BEM_ID = 1 and BSL_ID = 1 and BIL_ID = 3
   and Source_ID IN (104,110,111,118);
   
commit;   