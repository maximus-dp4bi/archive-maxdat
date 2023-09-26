insert into CORP_ETL_CONTROL
values ('CIR_RPT_START_DATE','D','2015/10/01','Start date parameter for the CoverKids Report', sysdate, sysdate);
insert into CORP_ETL_CONTROL
values ('CIR_MOVE_OR_REVIEW','V','M','Valid values R for Review, M for MoveIt.  Indicates whether the file should be moved directly to moveit folder or to be reviewed', sysdate, sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('MAGI_LAST_LOGID','N',0,'This is the max log id from MAGI_SERVICE_AUDIT_LOG table from previous run',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('MAGI_LAST_TRANS_DATAID','N',0,'This is the max log id from MAGI_SERVICE_AUDIT_LOG table from previous run',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('CIR_LAST_UPDATE_DATE','D',to_char(TRUNC(SYSDATE-360),'yyyy/mm/dd hh24:mi:ss'),'The date used to get the updates for the CIR table.',sysdate,sysdate);


commit;