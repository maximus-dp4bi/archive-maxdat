/*
Created on 09/09/2015 by Raj A.
Description: In an effort to performance tune WFM ETL process (NYHIX-16911 & NYHIX-17413), after discussing with Brendon, we revisited and decided to run the ETL once a day at 11 PM EST.
So, adjusting the global control to 1.
*/
update corp_etl_control
set value = 1
where name = 'WFM_NUM_ETL_RUNS_LOOK_BACK';
commit;