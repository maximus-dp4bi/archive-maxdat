REM INSERTING into PP_CFG_UNIT_OF_WORK
SET DEFINE OFF;

Insert into PP_CFG_PRODUCTION_PLAN (CFG_PRODUCTION_PLAN_ID,CFG_GEOGRAPHY_CONFIG_ID,CFG_PROJECT_CONFIG_ID,PRODUCTION_PLAN_NAME,PRODUCTION_PLAN_DESCRIPTION,EFFECTIVE_DATE,END_DATE,CREATE_DATE,LAST_UPDATE_DATE) values (1,1,1,'PAIEB_PROD_PLAN','PA IEB Production Planning',to_date('01-JUL-18','DD-MON-RR'),null,to_date('02-JUL-18','DD-MON-RR'),to_date('02-JUL-18','DD-MON-RR'));
Insert into PP_D_PRODUCTION_PLAN (PP_ID,PRODUCTION_PLAN_NAME,PRODUCTION_PLAN_DESCRIPTION,PROJECT_ID,PROGRAM_ID,GEOGRAPHY_MASTER_ID,EFFECTIVE_DATE,END_DATE,PP_CREATE_DATE,PP_LAST_UPDATE_DATE) values (1,'PAIEB_PROD_PLAN','PA IEB Production Planning',1,1,1,to_date('02-JUL-18','DD-MON-RR'),to_date('07-JUL-77','DD-MON-RR'),to_date('02-JUL-18','DD-MON-RR'),to_date('02-JUL-18','DD-MON-RR'));

insert into PP_CFG_PROGRAM_CONFIG(cfg_program_config_id,program_name)
values(1,'PA IEB');

insert into PP_D_SEGMENT(segment_id,segment_name)
values (1,'Enrollment Services');

Insert into PP_CFG_PROJECT_CONFIG (CFG_PROJECT_CONFIG_ID,SEGMENT_NAME,PROJECT_NAME,PROGRAM_NAME,CREATE_DATE,LAST_UPDATE_DATE) values (1,'Enrollment Services','PA IEB','Independent Enrollment Broker',to_date('02-JUL-18','DD-MON-RR'),to_date('02-JUL-18','DD-MON-RR'));

insert into pp_d_program(program_id,program_name)
values(1,'Independent Enrollment Broker');

insert into pp_d_country(country_id,country_name)
values(1,'US');

insert into pp_d_district(district_id)
values(1);

insert into pp_d_province(province_id)
values(1);

insert into pp_d_region(region_id,region_name)
values (1,'East');

insert into pp_d_site(site_id,site_name)
values(1,'Pennsylvania');

insert into pp_d_state(state_id,state_name)
values(1,'PA');

insert into PP_D_PROJECT (project_id,project_name,segment_id)
values (1,'PA IEB',1);

Insert into PP_CFG_GEOGRAPHY_CONFIG (CFG_GEOGRAPHY_CONFIG_ID,SITE_NAME,REGION_NAME,STATE_NAME,PROVINCE_NAME,DISTRICT_NAME,COUNTRY_NAME,RECORD_EFF_DT,RECORD_END_DT) values (1,'Pennsylvania','East','PA',null,null,'US',to_date('01-JUL-18','DD-MON-RR'),to_date('07-JUL-77','DD-MON-RR'));

Insert into PP_D_GEOGRAPHY_MASTER (GEOGRAPHY_MASTER_ID,GEOGRAPHY_NAME,COUNTRY_ID,STATE_ID,PROVINCE_ID,DISTRICT_ID,REGION_ID,SITE_ID) values (1,'PAIEB',1,1,1,1,1,1);



insert into pp_d_source(source_id,source_name,source_description)
values (1,'MANAGE WORK STG',	'Decision Point Manage Work Staging Table - Task Create Date to Complete Date');

insert into PP_D_SOURCE_REF_TYPE(source_ref_type_id,source_ref_type_name,source_id)
values (1,'TASK TYPE',1);

Insert into PP_CFG_UNIT_OF_WORK (CFG_UOW_ID,UNIT_OF_WORK_NAME,HOURLY_FLAG,HANDLE_TIME_UNIT,JEOPARDY_INV_AGE,AGE_DAYS_TYPE,INV_AVG_AGE,LABEL) values (1,'DE_NEW_APP','N','Minutes',2,'CAL',365,'Data Entry - New Application');
Insert into PP_CFG_UNIT_OF_WORK (CFG_UOW_ID,UNIT_OF_WORK_NAME,HOURLY_FLAG,HANDLE_TIME_UNIT,JEOPARDY_INV_AGE,AGE_DAYS_TYPE,INV_AVG_AGE,LABEL) values (2,'DE_APP_RENEWAL','N','Minutes',6,'CAL',365,'Data Entry - Application Renewal');
Insert into PP_CFG_UNIT_OF_WORK (CFG_UOW_ID,UNIT_OF_WORK_NAME,HOURLY_FLAG,HANDLE_TIME_UNIT,JEOPARDY_INV_AGE,AGE_DAYS_TYPE,INV_AVG_AGE,LABEL) values (3,'DE_APPEAL','N','Minutes',2,'CAL',365,'Data Entry - Appeal');
Insert into PP_CFG_UNIT_OF_WORK (CFG_UOW_ID,UNIT_OF_WORK_NAME,HOURLY_FLAG,HANDLE_TIME_UNIT,JEOPARDY_INV_AGE,AGE_DAYS_TYPE,INV_AVG_AGE,LABEL) values (5,'ELIG_NEW_APP','N','Minutes',15,'CAL',365,'Eligibility - New Application');
Insert into PP_CFG_UNIT_OF_WORK (CFG_UOW_ID,UNIT_OF_WORK_NAME,HOURLY_FLAG,HANDLE_TIME_UNIT,JEOPARDY_INV_AGE,AGE_DAYS_TYPE,INV_AVG_AGE,LABEL) values (7,'ELIG_RENEWAL','N','Minutes',2,'CAL',365,'Eligibility - Renewal');
Insert into PP_CFG_UNIT_OF_WORK (CFG_UOW_ID,UNIT_OF_WORK_NAME,HOURLY_FLAG,HANDLE_TIME_UNIT,JEOPARDY_INV_AGE,AGE_DAYS_TYPE,INV_AVG_AGE,LABEL) values (9,'BATCH','N','Minutes',2,'CAL',365,'Batch');
Insert into PP_CFG_UNIT_OF_WORK (CFG_UOW_ID,UNIT_OF_WORK_NAME,HOURLY_FLAG,HANDLE_TIME_UNIT,JEOPARDY_INV_AGE,AGE_DAYS_TYPE,INV_AVG_AGE,LABEL) values (10,'OTHER_INCOMING_DOCS','N','Minutes',2,'CAL',365,'Other Incoming Documents');
Insert into PP_CFG_UNIT_OF_WORK (CFG_UOW_ID,UNIT_OF_WORK_NAME,HOURLY_FLAG,HANDLE_TIME_UNIT,JEOPARDY_INV_AGE,AGE_DAYS_TYPE,INV_AVG_AGE,LABEL) values (11,'QC','N','Minutes',2,'CAL',365,'QC');
Insert into PP_CFG_UNIT_OF_WORK (CFG_UOW_ID,UNIT_OF_WORK_NAME,HOURLY_FLAG,HANDLE_TIME_UNIT,JEOPARDY_INV_AGE,AGE_DAYS_TYPE,INV_AVG_AGE,LABEL) values (13,'ENROLLMENT','N','Minutes',2,'CAL',365,'Enrollment');
Insert into PP_CFG_UNIT_OF_WORK (CFG_UOW_ID,UNIT_OF_WORK_NAME,HOURLY_FLAG,HANDLE_TIME_UNIT,JEOPARDY_INV_AGE,AGE_DAYS_TYPE,INV_AVG_AGE,LABEL) values (15,'LINK_CLASSIFY','N','Minutes',2,'CAL',365,'Link/Classify');

Insert into PP_D_UNIT_OF_WORK (UOW_ID,UNIT_OF_WORK_NAME,HANDLE_TIME_UNIT,JEOPARDY_INV_AGE,LABEL) values (1,'DE_NEW_APP','Minutes',3,'Data Entry - New Application');
Insert into PP_D_UNIT_OF_WORK (UOW_ID,UNIT_OF_WORK_NAME,HANDLE_TIME_UNIT,JEOPARDY_INV_AGE,LABEL) values (2,'DE_APP_RENEWAL','Minutes',2,'Data Entry - Application Renewal');
Insert into PP_D_UNIT_OF_WORK (UOW_ID,UNIT_OF_WORK_NAME,HANDLE_TIME_UNIT,JEOPARDY_INV_AGE,LABEL) values (3,'DE_APPEAL','Minutes',6,'Data Entry - Appeal');
Insert into PP_D_UNIT_OF_WORK (UOW_ID,UNIT_OF_WORK_NAME,HANDLE_TIME_UNIT,JEOPARDY_INV_AGE,LABEL) values (5,'ELIG_NEW_APP','Minutes',2,'Eligibility - New Application');
Insert into PP_D_UNIT_OF_WORK (UOW_ID,UNIT_OF_WORK_NAME,HANDLE_TIME_UNIT,JEOPARDY_INV_AGE,LABEL) values (7,'ELIG_RENEWAL','Minutes',3,'Eligibility - Renewal');
Insert into PP_D_UNIT_OF_WORK (UOW_ID,UNIT_OF_WORK_NAME,HANDLE_TIME_UNIT,JEOPARDY_INV_AGE,LABEL) values (9,'BATCH','Minutes',15,'Batch');
Insert into PP_D_UNIT_OF_WORK (UOW_ID,UNIT_OF_WORK_NAME,HANDLE_TIME_UNIT,JEOPARDY_INV_AGE,LABEL) values (10,'OTHER_INCOMING_DOCS','Minutes',4,'Other Incoming Documents');
Insert into PP_D_UNIT_OF_WORK (UOW_ID,UNIT_OF_WORK_NAME,HANDLE_TIME_UNIT,JEOPARDY_INV_AGE,LABEL) values (11,'QC','Minutes',2,'QC');
Insert into PP_D_UNIT_OF_WORK (UOW_ID,UNIT_OF_WORK_NAME,HANDLE_TIME_UNIT,JEOPARDY_INV_AGE,LABEL) values (13,'ENROLLMENT','Minutes',2,'Enrollment');
Insert into PP_D_UNIT_OF_WORK (UOW_ID,UNIT_OF_WORK_NAME,HANDLE_TIME_UNIT,JEOPARDY_INV_AGE,LABEL) values (15,'LINK_CLASSIFY','Minutes',2,'Link/Classify');


insert into pp_d_uow_source_ref(usr_id,uow_id,source_ref_type_id,source_ref_value,source_ref_detail_identifier,effective_date,end_date,source_ref_id)
select task_type_id,task_type_id,1,task_name,'TASK ID',trunc(sysdate),to_date('07/07/7777','mm/dd/yyyy'),task_type_id
from d_task_types;

Insert into PP_D_PRODUCTION_PLAN_HORIZON (PPH_ID,PP_ID,HORIZON_START_DATE,HORIZON_START_HOUR,HORIZON_END_DATE,HORIZON_END_HOUR,HORIZON_NAME,HORIZON_DESCRIPTION,FORECAST_LAST_MODIFIED_DATE,CREATE_DATE,LAST_UPDATE_DATE) values (101,1,to_date('03-DEC-18','DD-MON-RR'),0,to_date('30-DEC-18','DD-MON-RR'),0,'12/03/2018 - 12/30/2018',null,to_date('07-DEC-18','DD-MON-RR'),to_date('07-DEC-18','DD-MON-RR'),to_date('07-DEC-18','DD-MON-RR'));
Insert into PP_D_PRODUCTION_PLAN_HORIZON (PPH_ID,PP_ID,HORIZON_START_DATE,HORIZON_START_HOUR,HORIZON_END_DATE,HORIZON_END_HOUR,HORIZON_NAME,HORIZON_DESCRIPTION,FORECAST_LAST_MODIFIED_DATE,CREATE_DATE,LAST_UPDATE_DATE) values (121,1,to_date('21-JAN-19','DD-MON-RR'),0,to_date('17-FEB-19','DD-MON-RR'),0,'01/21/2019 - 02/17/2019',null,to_date('18-JAN-19','DD-MON-RR'),to_date('18-JAN-19','DD-MON-RR'),to_date('18-JAN-19','DD-MON-RR'));
Insert into PP_D_PRODUCTION_PLAN_HORIZON (PPH_ID,PP_ID,HORIZON_START_DATE,HORIZON_START_HOUR,HORIZON_END_DATE,HORIZON_END_HOUR,HORIZON_NAME,HORIZON_DESCRIPTION,FORECAST_LAST_MODIFIED_DATE,CREATE_DATE,LAST_UPDATE_DATE) values (41,1,to_date('06-AUG-18','DD-MON-RR'),0,to_date('02-SEP-18','DD-MON-RR'),0,'08/06/2018 - 09/02/2018',null,to_date('02-AUG-18','DD-MON-RR'),to_date('02-AUG-18','DD-MON-RR'),to_date('02-AUG-18','DD-MON-RR'));
Insert into PP_D_PRODUCTION_PLAN_HORIZON (PPH_ID,PP_ID,HORIZON_START_DATE,HORIZON_START_HOUR,HORIZON_END_DATE,HORIZON_END_HOUR,HORIZON_NAME,HORIZON_DESCRIPTION,FORECAST_LAST_MODIFIED_DATE,CREATE_DATE,LAST_UPDATE_DATE) values (61,1,to_date('03-SEP-18','DD-MON-RR'),0,to_date('30-SEP-18','DD-MON-RR'),0,'09/03/2018 - 09/30/2018',null,to_date('06-SEP-18','DD-MON-RR'),to_date('06-SEP-18','DD-MON-RR'),to_date('06-SEP-18','DD-MON-RR'));
Insert into PP_D_PRODUCTION_PLAN_HORIZON (PPH_ID,PP_ID,HORIZON_START_DATE,HORIZON_START_HOUR,HORIZON_END_DATE,HORIZON_END_HOUR,HORIZON_NAME,HORIZON_DESCRIPTION,FORECAST_LAST_MODIFIED_DATE,CREATE_DATE,LAST_UPDATE_DATE) values (81,1,to_date('01-OCT-18','DD-MON-RR'),0,to_date('28-OCT-18','DD-MON-RR'),0,'10/01/2018 - 10/28/2018',null,to_date('01-OCT-18','DD-MON-RR'),to_date('01-OCT-18','DD-MON-RR'),to_date('01-OCT-18','DD-MON-RR'));


commit;