-- adjust FK to point to D_PROGRAM table instead of CC_D_PROGRAM

-- CC_F_PROJECT_BY_DATE
alter table cc_f_project_by_date
drop constraint CC_F_PRJ_BY_DT_CC_D_PRGM_FK;

update cc_f_project_by_date
set d_program_id = case
                    when d_program_id = 1 then 3
                    when d_program_id = 2 then 1
                    when d_program_id = 3 then 2
                    when d_program_id = 4 then 4
                    else 0
                   end;

alter table cc_f_project_by_date
add constraint CC_F_PRJ_BY_DT_CC_D_PRGM_FK
  foreign key (d_program_id)
  references d_program (d_program_id);

-- CC_F_AGENT_BY_DATE
alter table cc_f_agent_by_date
drop constraint CC_F_AGENT_DATE_D_PROGRAM_FK;

update cc_f_agent_by_date
set d_program_id = case
                    when d_program_id = 1 then 3
                    when d_program_id = 2 then 1
                    when d_program_id = 3 then 2
                    when d_program_id = 4 then 4
                    else 0
                   end;

alter table cc_f_agent_by_date
add constraint CC_F_AGENT_DATE_D_PROGRAM_FK
  foreign key (d_program_id)
  references d_program (d_program_id);

-- CC_F_ACTUALS_QUEUE_INTERVAL
alter table cc_f_actuals_queue_interval
drop constraint F_ACTLS_Q_INTRVL_D_PRG_FK;

update cc_f_actuals_queue_interval
set d_program_id = case
                    when d_program_id = 1 then 3
                    when d_program_id = 2 then 1
                    when d_program_id = 3 then 2
                    when d_program_id = 4 then 4
                    else 0
                   end;

alter table cc_f_actuals_queue_interval
add constraint F_ACTLS_Q_INTRVL_D_PRG_FK
  foreign key (d_program_id)
  references d_program (d_program_id);

-- CC_F_AGENT_ACTIVITY_BY_DATE
alter table cc_f_agent_activity_by_date
drop constraint CC_F_AGNT_ACT_D_PROGRAM_FK;

update cc_f_agent_activity_by_date
set d_program_id = case
                    when d_program_id = 1 then 3
                    when d_program_id = 2 then 1
                    when d_program_id = 3 then 2
                    when d_program_id = 4 then 4
                    else 0
                   end;

alter table cc_f_agent_activity_by_date
add constraint CC_F_AGNT_ACT_D_PROGRAM_FK
  foreign key (d_program_id)
  references d_program (d_program_id);

-- CC_F_ACTUALS_IVR_INTERVAL
alter table cc_f_actuals_ivr_interval
drop constraint F_ACTLS_IVR_INTRVL_D_PRG_FK;

update cc_f_actuals_ivr_interval
set d_program_id = case
                    when d_program_id = 1 then 3
                    when d_program_id = 2 then 1
                    when d_program_id = 3 then 2
                    when d_program_id = 4 then 4
                    else 0
                   end;

alter table cc_f_actuals_ivr_interval
add constraint F_ACTLS_IVR_INTRVL_D_PRG_FK
  foreign key (d_program_id)
  references d_program (d_program_id);

-- CC_F_IVR_SELF_SERVICE_USAGE
alter table cc_f_ivr_self_service_usage
drop constraint F_IVR_SELF_SVC_D_PRG_FK;

update cc_f_ivr_self_service_usage
set d_program_id = case
                    when d_program_id = 1 then 3
                    when d_program_id = 2 then 1
                    when d_program_id = 3 then 2
                    when d_program_id = 4 then 4
                    else 0
                   end;

alter table cc_f_ivr_self_service_usage
add constraint F_IVR_SELF_SVC_D_PRG_FK
  foreign key (d_program_id)
  references d_program (d_program_id);

-- CC_D_PRODUCTION_PLAN
alter table cc_d_production_plan
drop constraint CC_D_PROD_PLAN_D_PRG_FK;

update cc_d_production_plan
set program_id = case
                    when program_id = 1 then 3
                    when program_id = 2 then 1
                    when program_id = 3 then 2
                    when program_id = 4 then 4
                    else 0
                   end;

alter table cc_d_production_plan
add constraint CC_D_PROD_PLAN_D_PRG_FK
  foreign key (program_id)
  references d_program (d_program_id);

-- drop old table
drop table cc_d_program;

INSERT INTO CC_L_PATCH_LOG (PATCH_VERSION, SCRIPT_SEQUENCE, SCRIPT_NAME) 
VALUES ('2.3','017','017_FIX_D_PROGRAM_FK_ALL_TABLES');

COMMIT;