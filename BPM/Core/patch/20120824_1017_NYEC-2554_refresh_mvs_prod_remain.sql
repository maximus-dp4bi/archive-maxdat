-- Dimensions By Date
execute dbms_mview.refresh('V_D_STATUS_DATE','?');
execute dbms_mview.refresh('V_D_TASK_STATUS','?');
execute dbms_mview.refresh('V_D_TASK_TYPE','?');
execute dbms_mview.refresh('V_D_TEAM_NAME','?');
execute dbms_mview.refresh('V_D_TEAM_PARENT_NAME','?');
execute dbms_mview.refresh('V_D_TEAM_SUPERVISOR_NAME','?');

-- Facts By Date
execute dbms_mview.refresh('V_F_BPM_INSTANCE_BY_DATE','?');