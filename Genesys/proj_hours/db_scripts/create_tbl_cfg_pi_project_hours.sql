use schema public;

create table cfg_pi_project_hours (
	PROJECT_ID varchar(10) not null,
	PROJECT_NAME varchar(50) not null,
	PROJECT_TIME_ZONE varchar(50) not null,
	PROJECT_HOURS_START_TIME varchar(5) not null,
	PROJECT_HOURS_END_TIME varchar(5) not null,
	PROJECT_HOURS_WEEK_DAY varchar(1) not null,
    	CHECK_FLAG varchar(1),
    	CREATED_AT timestamp_ntz,
    	CREATED_BY varchar(100),
    	UPDATED_AT timestamp_ntz,
    	UPDATED_BY varchar(100)
  );

alter table cfg_pi_project_hours add constraint unq_cfg_pi_project_hours unique (project_id,project_hours_week_day) enforced;


