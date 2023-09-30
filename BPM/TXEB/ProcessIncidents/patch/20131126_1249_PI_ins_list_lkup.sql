-- 11/26/13 B.Thai for TX scheduling

Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) values ('INCIDENT_SCHEDULE_BEG','N','2000','Incidents to run once daily on TXEB. Represents the hour value on 24-hour format.',SYSDATE,SYSDATE);
Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) values ('INCIDENT_SCHEDULE_END','N','2259','Incidents to run once daily on TXEB. Represents the hour value on 24-hour format.',SYSDATE,SYSDATE);

commit;