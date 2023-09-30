/*
Created on 11/17/2014 by Raj A.
Description:
There is a bug in the Jeopardy_Flag. So, fixed the semantic package and updating for completed instances only. Active instances will be updated in the daily run.
*/
update D_MW_V2_CURRENT
set 
JEOPARDY_FLAG = maxdat.MW_V2.GET_JEOPARDY_FLAG(TASK_TYPE_ID,
											   CURR_WORK_RECEIPT_DATE,
											   INSTANCE_END_DATE
                                              )
where
INSTANCE_END_DATE is not null
or CANCEL_WORK_DATE is not null;
commit;