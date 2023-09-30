-- adjust FK to point to D_GEOGRAPHY_MASTER table instead of CC_D_GEOGRAPHY_MASTER

-- CC_F_PROJECT_BY_DATE
alter table cc_f_project_by_date
drop constraint CC_F_PRJ_BY_DT_CC_D_GEO_M_FK;

update cc_f_project_by_date
set d_geography_master_id = case
                    when d_geography_master_id = 1 then 8
                    when d_geography_master_id = 2 then 2
                    else 0
                   end;

alter table cc_f_project_by_date
add constraint CC_F_PRJ_BY_DT_CC_D_GEO_M_FK
  foreign key (d_geography_master_id)
  references d_geography_master (d_geography_master_id);

-- CC_F_AGENT_BY_DATE
alter table cc_f_agent_by_date
drop constraint CC_F_AGENT_DATE_D_GEO_FK;

update cc_f_agent_by_date
set d_geography_master_id = case
                    when d_geography_master_id = 1 then 8
                    when d_geography_master_id = 2 then 2
                    else 0
                   end;

alter table cc_f_agent_by_date
add constraint CC_F_AGENT_DATE_D_GEO_FK
  foreign key (d_geography_master_id)
  references d_geography_master (d_geography_master_id);

-- CC_F_ACTUALS_QUEUE_INTERVAL
alter table cc_f_actuals_queue_interval
drop constraint F_ACTLS_Q_INTRVL_D_GEO_FK;

update cc_f_actuals_queue_interval
set d_geography_master_id = case
                    when d_geography_master_id = 1 then 8
                    when d_geography_master_id = 2 then 2
                    else 0
                   end;

alter table cc_f_actuals_queue_interval
add constraint F_ACTLS_Q_INTRVL_D_GEO_FK
  foreign key (d_geography_master_id)
  references d_geography_master (d_geography_master_id);

-- CC_F_AGENT_ACTIVITY_BY_DATE
alter table cc_f_agent_activity_by_date
drop constraint CC_F_AGNT_ACT_D_GEO_MSTR_FK;

update cc_f_agent_activity_by_date
set d_geography_master_id = case
                    when d_geography_master_id = 1 then 8
                    when d_geography_master_id = 2 then 2
                    else 0
                   end;

alter table cc_f_agent_activity_by_date
add constraint CC_F_AGNT_ACT_D_GEO_MSTR_FK
  foreign key (d_geography_master_id)
  references d_geography_master (d_geography_master_id);

-- CC_F_ACTUALS_IVR_INTERVAL
alter table cc_f_actuals_ivr_interval
drop constraint F_ACTLS_IVR_INTRVL_D_GEO_FK;

update cc_f_actuals_ivr_interval
set d_geography_master_id = case
                    when d_geography_master_id = 1 then 8
                    when d_geography_master_id = 2 then 2
                    else 0
                   end;

alter table cc_f_actuals_ivr_interval
add constraint F_ACTLS_IVR_INTRVL_D_GEO_FK
  foreign key (d_geography_master_id)
  references d_geography_master (d_geography_master_id);

-- CC_F_IVR_SELF_SERVICE_USAGE
alter table cc_f_ivr_self_service_usage
drop constraint F_IVR_SELF_SVC_D_GEO_FK;

update cc_f_ivr_self_service_usage
set d_geography_master_id = case
                    when d_geography_master_id = 1 then 8
                    when d_geography_master_id = 2 then 2
                    else 0
                   end;

alter table cc_f_ivr_self_service_usage
add constraint F_IVR_SELF_SVC_D_GEO_FK
  foreign key (d_geography_master_id)
  references d_geography_master (d_geography_master_id);

-- CC_D_PRODUCTION_PLAN
alter table cc_d_production_plan
drop constraint CC_D_PROD_PLAN_D_GEO_FK;

update cc_d_production_plan
set geography_master_id = case
                    when geography_master_id = 1 then 8
                    when geography_master_id = 2 then 2
                    else 0
                   end;

alter table cc_d_production_plan
add constraint CC_D_PROD_PLAN_D_GEO_FK
  foreign key (geography_master_id)
  references d_geography_master (d_geography_master_id);

-- drop old table
drop table cc_d_geography_master;

INSERT INTO CC_L_PATCH_LOG (PATCH_VERSION, SCRIPT_SEQUENCE, SCRIPT_NAME) 
VALUES ('2.3','018','018_FIX_D_GEO_MASTER_FK_ALL_TABLES');

COMMIT;