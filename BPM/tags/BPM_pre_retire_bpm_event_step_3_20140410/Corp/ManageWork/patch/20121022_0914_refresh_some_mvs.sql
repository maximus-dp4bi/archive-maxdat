dbms_mview.refresh('V_D_STATUS_DAT','?');
dbms_mview.refresh('V_D_TASK_TYPE','?');
dbms_mview.refresh('V_D_STATUS_AGE_IN_BUS_DAYS','?');
dbms_mview.refresh('V_D_SOURCE_REFERENCE_TYPE','?');
dbms_mview.refresh('V_D_TEAM_NAME','?');
dbms_mview.refresh('V_D_TASK_ID','?');
dbms_mview.refresh('V_D_TASK_STATUS','?');
dbms_mview.refresh('V_D_TEAM_SUPERVISOR_NAME','?');
dbms_mview.refresh('V_D_TEAM_PARENT_NAME','?');
dbms_mview.refresh('V_D_OWNER_NAME','?');
dbms_mview.refresh('V_D_UNIT_OF_WORK','?');
dbms_mview.refresh('V_D_LAST_UPDATE_DATE','?');
dbms_mview.refresh('V_D_LAST_UPDATE_BY_NAME','?');
dbms_mview.refresh('V_D_ESCALATED_FLAG','?');
dbms_mview.refresh('V_D_ESCALATED_TO_NAME','?');
dbms_mview.refresh('V_D_FORWARDED_FLAG','?');
dbms_mview.refresh('V_D_FORWARDED_BY_NAME','?');
dbms_mview.refresh('V_D_GROUP_NAME','?');
dbms_mview.refresh('V_D_GROUP_SUPERVISOR_NAME','?');
dbms_mview.refresh('V_D_GROUP_PARENT_NAME','?');
dbms_mview.refresh('V_F_BPM_INSTANCE_BY_DATE','?');

UPDATE MAXDAT.CORP_BPM_MV_REFRESH
SET PROCESS = 'ManageWork'
WHERE PROCESS = 'ManageWork_stop';

commit;
