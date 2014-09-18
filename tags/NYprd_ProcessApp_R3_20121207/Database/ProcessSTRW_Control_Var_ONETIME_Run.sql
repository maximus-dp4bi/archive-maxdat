/*
v1 Raj A.  09-Oct-2012 Updated to 31.

Description:
On the day of the deployment, for the first time ETL run, this global value should be 31.
After that for every day run, it should be 5 (just like Process MI logic).
*/


update corp_etl_control
   set value = 31,
       updated_ts = sysdate      	
 where name = 'STATE_REVIEW_LOOK_BACK_DAYS';
commit;