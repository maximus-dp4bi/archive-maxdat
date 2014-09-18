UPDATE MAXDAT.CORP_BPM_MV_REFRESH
SET PROCESS = 'ManageWork_stop'
WHERE PROCESS = 'ManageWork';

commit;


execute dbms_mview.refresh('V_D_AGE_IN_BUSINESS_DAYS','?');
execute dbms_mview.refresh('V_D_CANCEL_WORK_DATE','?');
execute dbms_mview.refresh('V_D_COMPLETE_DATE','?');
execute dbms_mview.refresh('V_D_CREATE_DATE','?');
execute dbms_mview.refresh('V_D_CREATED_BY_NAME','?');
execute dbms_mview.refresh('V_D_ESCALATED_FLAG','?');
execute dbms_mview.refresh('V_D_ESCALATED_TO_NAME','?');
execute dbms_mview.refresh('V_D_FORWARDED_BY_NAME','?');
execute dbms_mview.refresh('V_D_FORWARDED_FLAG','?');
execute dbms_mview.refresh('V_D_GROUP_NAME','?');
execute dbms_mview.refresh('V_D_GROUP_PARENT_NAME','?');
execute dbms_mview.refresh('V_D_GROUP_SUPERVISOR_NAME','?');
execute dbms_mview.refresh('V_D_LAST_UPDATE_BY_NAME','?');
execute dbms_mview.refresh('V_D_LAST_UPDATE_DATE','?');
execute dbms_mview.refresh('V_D_OWNER_NAME','?');
execute dbms_mview.refresh('V_D_SLA_DAYS','?');
execute dbms_mview.refresh('V_D_SLA_DAYS_TYPE','?');
execute dbms_mview.refresh('V_D_SLA_JEOPARDY_DAYS','?');
execute dbms_mview.refresh('V_D_SLA_TARGET_DAYS','?');
execute dbms_mview.refresh('V_D_SOURCE_REFERENCE_ID','?');
execute dbms_mview.refresh('V_D_SOURCE_REFERENCE_TYPE','?');
execute dbms_mview.refresh('V_D_STATUS_AGE_IN_BUS_DAYS','?');
execute dbms_mview.refresh('V_D_STATUS_DATE','?');
execute dbms_mview.refresh('V_D_TASK_ID','?');
execute dbms_mview.refresh('V_D_TASK_STATUS','?');
execute dbms_mview.refresh('V_D_TASK_TYPE','?');
execute dbms_mview.refresh('V_D_TEAM_NAME','?');
execute dbms_mview.refresh('V_D_TEAM_PARENT_NAME','?');
execute dbms_mview.refresh('V_D_TEAM_SUPERVISOR_NAME','?');
execute dbms_mview.refresh('V_D_UNIT_OF_WORK','?');
execute dbms_mview.refresh('V_F_BPM_INSTANCE_BY_DATE','?');


UPDATE MAXDAT.CORP_BPM_MV_REFRESH
SET PROCESS = 'ManageWork'
WHERE PROCESS = 'ManageWork_stop';

commit;
