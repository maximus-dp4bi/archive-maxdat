
insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('IMR_NUM_ETL_RUNS_LOOK_BACK','N',1,'Looks back specified number of successful ETL runs while searching for new IMR. 1-previous run; 2-second from last run.',sysdate,sysdate);

commit;