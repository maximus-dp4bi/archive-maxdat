-- adjust FK to point to D_PROJECT table instead of CC_D_PROJECT

-- CC_D_PROJECT_TARGETS
ALTER TABLE CC_D_PROJECT_TARGETS
DROP CONSTRAINT CC_D_PRJ_TARGETS_D_PRJ_FK;

update cc_d_project_targets
set project_id = CASE
                    WHEN project_id = 1 THEN 83
                    WHEN project_id = 2 THEN 1
                    WHEN project_id = 21 THEN 81
                    ELSE 0
                    END;

alter table cc_d_project_targets
add constraint CC_D_PRJ_TARGETS_D_PRJ_FK
  foreign key (d_project_id)
  references d_project (d_project_id);
  
-- CC_F_ACTUALS_QUEUE_INTERVAL
alter table cc_f_actuals_queue_interval
drop constraint F_ACTLS_Q_INTRVL_D_PRJ_FK;

update cc_f_actuals_queue_interval
set d_project_id = case
                    when d_project_id = 1 then 83
                    when d_project_id = 2 then 1
                    when d_project_id = 21 then 81
                    else 0
                   end;

alter table cc_f_actuals_queue_interval
add constraint F_ACTLS_Q_INTRVL_D_PRJ_FK
  foreign key (d_project_id)
  references d_project (d_project_id);

-- CC_F_AGENT_ACTIVITY_BY_DATE
alter table cc_f_agent_activity_by_date
drop constraint CC_F_AGNT_ACT_D_PROJECT_FK;

update cc_f_agent_activity_by_date
set d_project_id = case
                    when d_project_id = 1 then 83
                    when d_project_id = 2 then 1
                    when d_project_id = 21 then 81
                    else 0
                   end;

alter table cc_f_agent_activity_by_date
add constraint CC_F_AGNT_ACT_D_PROJECT_FK
  foreign key (d_project_id)
  references d_project (d_project_id);

-- CC_F_ACTUALS_IVR_INTERVAL
alter table cc_f_actuals_ivr_interval
drop constraint F_ACTLS_IVR_INTRVL_D_PRJ_FK;

update cc_f_actuals_ivr_interval
set d_project_id = case
                    when d_project_id = 1 then 83
                    when d_project_id = 2 then 1
                    when d_project_id = 21 then 81
                    else 0
                   end;

alter table cc_f_actuals_ivr_interval
add constraint F_ACTLS_IVR_INTRVL_D_PRJ_FK
  foreign key (d_project_id)
  references d_project (d_project_id);

-- CC_F_IVR_SELF_SERVICE_USAGE
alter table cc_f_ivr_self_service_usage
drop constraint F_IVR_SELF_SVC_D_PRJ_FK;

update cc_f_ivr_self_service_usage
set d_project_id = case
                    when d_project_id = 1 then 83
                    when d_project_id = 2 then 1
                    when d_project_id = 21 then 81
                    else 0
                   end;

alter table cc_f_ivr_self_service_usage
add constraint F_IVR_SELF_SVC_D_PRJ_FK
  foreign key (d_project_id)
  references d_project (d_project_id);

-- CC_D_PRODUCTION_PLAN
alter table cc_d_production_plan
drop constraint CC_D_PROD_PLAN_D_PRJ_FK;

update cc_d_production_plan
set project_id = case
                    when project_id = 1 then 83
                    when project_id = 2 then 1
                    when project_id = 21 then 81
                    else 0
                   end;

alter table cc_d_production_plan
add constraint CC_D_PROD_PLAN_D_PRJ_FK
  foreign key (project_id)
  references d_project (d_project_id);

-- CC_D_PROD_PLANNING_TARGET
alter table cc_d_prod_PLANNING_TARGET
drop constraint CC_D_PRD_PLN_TRGT_CC_D_PRJ_FK;

update cc_d_prod_planning_target
set d_project_id = case
                    when d_project_id = 1 then 83
                    when d_project_id = 2 then 1
                    when d_project_id = 21 then 81
                    else 0
                   end;

alter table cc_d_prod_planning_target
add constraint CC_D_PRD_PLN_TRGT_CC_D_PRJ_FK
  foreign key (d_project_id)
  references d_project (d_project_id);

-- drop old table
drop table cc_d_project;

INSERT INTO CC_L_PATCH_LOG (PATCH_VERSION, SCRIPT_SEQUENCE, SCRIPT_NAME) 
VALUES ('2.3','015','015_FIX_D_PROJECT_FK_ALL_TABLES');

COMMIT;