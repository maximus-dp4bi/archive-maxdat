----
--- INSERTING into INCIDENT_STATUS_LOOKUP for NYHIX-41243
SET DEFINE OFF;
Insert into INCIDENT_STATUS_LOOKUP (INCIDENT_STATUS,STATUS_CD,START_STOP,MODULE) 
values ('Adjournment - DOH Request','ADJOURNMENT_DOH_REQUEST','COUNT','APPEAL');

Insert into INCIDENT_STATUS_LOOKUP (INCIDENT_STATUS,STATUS_CD,START_STOP,MODULE) 
values ('Hearing Held - Count Clock','HEARING_HELD_COUNT_CLOCK','COUNT','APPEAL');

Insert into INCIDENT_STATUS_LOOKUP (INCIDENT_STATUS,STATUS_CD,START_STOP,MODULE) 
values ('Adjournment - Appellant Request','ADJOURNMENT_APPELLANT_REQUEST','STOP','APPEAL');

Insert into INCIDENT_STATUS_LOOKUP (INCIDENT_STATUS,STATUS_CD,START_STOP,MODULE) 
values ('Hearing Held - Stop Clock','HEARING_HELD_STOP_CLOCK','STOP','APPEAL');

commit;
