--- NYHIX-54187 for Maxe 53.0.0

Insert into D_TASK_TYPES (TASK_TYPE_ID,TASK_NAME,TASK_DESCRIPTION,OPERATIONS_GROUP,SLA_DAYS,SLA_DAYS_TYPE,SLA_TARGET_DAYS,SLA_JEOPARDY_DAYS,UNIT_OF_WORK) 
            values (2019014,'DPR – Nav/CAC ID Proofing','DPR – Nav/CAC ID Proofing','Research',2,'B',2,null,null);
Insert into D_TASK_TYPES (TASK_TYPE_ID,TASK_NAME,TASK_DESCRIPTION,OPERATIONS_GROUP,SLA_DAYS,SLA_DAYS_TYPE,SLA_TARGET_DAYS,SLA_JEOPARDY_DAYS,UNIT_OF_WORK) 
            values (2019015,'DPR – Linking','DPR – Linking','Research',2,'B',2,null,null);
insert into BPM_D_OPS_GROUP_TASK (OPS_GROUP,TASK_TYPE) values ('Research','DPR – Nav/CAC ID Proofing');
insert into BPM_D_OPS_GROUP_TASK (OPS_GROUP,TASK_TYPE) values ('Research','DPR – Linking');
commit;