/*
Created on 12-Jun-2014 by Raj A.
*/
insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('INC_NUM_ETL_RUNS_LOOK_BACK','N',2,'Looks back specified number of successful ETL runs while searching for new Incidents. 1-previous run; 2-second from last run.',sysdate,sysdate);

commit;