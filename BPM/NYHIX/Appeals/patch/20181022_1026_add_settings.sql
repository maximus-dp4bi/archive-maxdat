--------------------------------------------------------
--  File created - Friday-October-19-2018   
--------------------------------------------------------
REM INSERTING into MAXDAT.CORP_ETL_CONTROL
SET DEFINE OFF;
Insert into MAXDAT.CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) values ('INCIDENT_HEADER_STAT_HIST_ID_START','N','1','Starting number for the appeals_life_cycle process',to_date('22-OCT-18','DD-MON-RR'),to_date('22-OCT-18','DD-MON-RR'));
Insert into MAXDAT.CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) values ('INCIDENT_HEADER_STAT_HIST_ID_END','N','98980','Ending number for appeals_life cycle process',to_date('22-OCT-18','DD-MON-RR'),to_date('22-OCT-18','DD-MON-RR'));
