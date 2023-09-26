insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('WFM_NUM_ETL_RUNS_LOOK_BACK','N',5,'Looks back specified number of successful ETL runs while searching for new Incidents. 1-previous run; 2-second from last run.',sysdate,sysdate);

commit;