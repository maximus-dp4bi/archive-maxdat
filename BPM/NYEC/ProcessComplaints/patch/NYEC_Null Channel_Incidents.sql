alter session set current_schema = MAXDAT;
UPDATE MAXDAT.CORP_ETL_COMPLAINTS_INCIDENTS SET INCIDENT_STATUS = 'Complete',INSTANCE_COMPLETE_DT = LAST_UPDATE_BY_DT,STAGE_DONE_DT = Sysdate,COMPLETE_DT = LAST_UPDATE_BY_DT WHERE incident_id  = 26231045;
commit;
