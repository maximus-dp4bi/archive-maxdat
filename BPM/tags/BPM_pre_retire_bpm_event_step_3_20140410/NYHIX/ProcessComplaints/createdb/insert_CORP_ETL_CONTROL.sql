insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('PC_LAST_COMPLAINT','N',0,'Used to fetch Incidents from OLTP for ProcessComplaints  Incidents process',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('COMP_LOOK_BACK_DAYS','N',300,'Looks back specified number of days while searching for new Complaints Incidents',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('COMPLAINTS_TO_LOOK_BACK','N','1000','Number of complaints incidents to look back',sysdate,sysdate);

commit;