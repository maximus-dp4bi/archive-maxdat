insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('LAST_APPEAL_ID','N',0,'Used to fetch Appeals from OLTP for Appeals process',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('APP_LOOK_BACK_DAYS','N',30,'Looks back specified number of days while searching for new Appeals',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('APPEALS_TO_LOOK_BACK','N','100','Number of incidents to look back',sysdate,sysdate);

commit;