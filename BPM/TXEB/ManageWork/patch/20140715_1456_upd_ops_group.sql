-- TXEB-2878

update BPM_D_OPS_GROUP_TASK  set OPS_GROUP= 'Special Services Unit' where TASK_TYPE = '1087 Home Visit';
update BPM_D_OPS_GROUP_TASK  set OPS_GROUP= 'Health Plan Liaison' where TASK_TYPE = 'HPL Research Review Task';
update BPM_D_OPS_GROUP_TASK  set OPS_GROUP= 'Special Services Unit' where TASK_TYPE = 'HPL Complaint';
update BPM_D_OPS_GROUP_TASK  set OPS_GROUP= 'Special Services Unit Admin' where TASK_TYPE = 'Referral Follow-up Task';
update BPM_D_OPS_GROUP_TASK  set OPS_GROUP= 'Special Services Unit' where TASK_TYPE = 'HHSC Complaint';
update BPM_D_OPS_GROUP_TASK  set OPS_GROUP= 'Special Services Unit' where TASK_TYPE = 'SEU Complaint';
update BPM_D_OPS_GROUP_TASK  set OPS_GROUP= 'Outreach' where TASK_TYPE = 'SSI Home Visit';
update BPM_D_OPS_GROUP_TASK  set OPS_GROUP= 'Outreach' where TASK_TYPE = 'HCO Home Visit';
update BPM_D_OPS_GROUP_TASK  set OPS_GROUP= 'Outreach' where TASK_TYPE = 'Pregnant Teen Home Visit';

-- ETL Task Group
UPDATE corp_etl_list_lkup SET  out_var = 'Special Services Unit'
 WHERE name = 'TASK_MONITOR_TYPE' AND list_type = 'LIST'
   AND value IN ('HPL Complaint','HHSC Complaint','SEU Complaint');

COMMIT;