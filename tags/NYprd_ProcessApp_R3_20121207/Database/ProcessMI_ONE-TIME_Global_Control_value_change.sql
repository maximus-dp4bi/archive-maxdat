/*
Created by Raj A. on 23-Aug-2012.
v2 Raj A.  28-Aug-2012 Updated to 5.

Description:
After the One-time run of the ETL, run this script to set the Global control table
to fetch completed Apps from past five days(just in case we missed to run the ETL in a day).
This is as per Devin H.
*/


update corp_etl_control
   set value = 5,
       updated_ts = sysdate      	
 where name = 'PRO_MI_CDC_MI_TASKS';
commit;