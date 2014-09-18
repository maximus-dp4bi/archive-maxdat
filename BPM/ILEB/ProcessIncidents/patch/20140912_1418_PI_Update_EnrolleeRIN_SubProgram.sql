/*
Created on 12-Sep-2014 by Raj A. for ILEB-3862
*/
update corp_etl_process_incidents
   set enrollee_rin = '196953467' 
 where incident_id = 588253;

update corp_etl_process_incidents
   set enrollee_rin = '138658299' 
 where incident_id = 986007;

update corp_etl_process_incidents
   set enrollee_rin = '146635735' 
 where incident_id = 1224645;
 
update corp_etl_process_incidents
   set enrollee_rin = '317175966',
       program_subtype = null
 where incident_id = 1347640;

update corp_etl_process_incidents
   set enrollee_rin = '227829991' 
 where incident_id = 1897138;
 commit; 