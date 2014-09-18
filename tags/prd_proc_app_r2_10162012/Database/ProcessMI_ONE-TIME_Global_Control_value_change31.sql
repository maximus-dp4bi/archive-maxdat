/*
Created by Raj A. on 14-Sep-2012.
v1 Raj A.  14-Sep-2012 Updated to 31.

Description:
During deployment on 14-Sep, the first script errored out but DBAs updated the global control to 5.
So, reverting back to 31 to run one-time again.
*/


update corp_etl_control
   set value = 31,
       updated_ts = sysdate      	
 where name = 'PRO_MI_CDC_MI_TASKS';
commit;