insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('MAX_SURVEY_CREATE_DATE','D',20180101,'Max create ts from previous run',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('MAX_SURVEY_UPDATE_DATE','D',20180101,'Max update ts from previous run',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('MAX_SURVEY_HEADER_CREATE_DATE','D',20180101,'Max create ts from previous run',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('MAX_SURVEY_HEADER_UPDATE_DATE','D',20180101,'Max update ts from previous run',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('MAX_SURVEY_SCORE_CREATE_DATE','D',20180101,'Max create ts from previous run',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('MAX_SURVEY_SCORE_UPDATE_DATE','D',20180101,'Max update ts from previous run',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('MAX_SURVEY_RESP_CREATE_DATE','D',20180101,'Max create ts from previous run',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('MAX_SURVEY_RESP_UPDATE_DATE','D',20180101,'Max update ts from previous run',sysdate,sysdate);

update corp_etl_list_lkup 
set value = '1'
where name = 'QC_LOOKUP_ALL' and list_type = 'QC';

commit;