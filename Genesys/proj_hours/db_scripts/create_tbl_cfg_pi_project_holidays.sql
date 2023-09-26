use schema public;

create table cfg_pi_project_holidays (
	PROJECT_ID varchar(10) not null,
	PROJECT_NAME varchar(50) not null,
	PROJECT_TIME_ZONE varchar(50) not null,
	PROJECT_HOLIDAY_DATE date not null,
    	HOLIDAY_NAME varchar(100),
    	CHECK_FLAG number(1),
    	CREATED_AT timestamp_ntz,
    	CREATED_BY varchar(100),
    	UPDATED_AT timestamp_ntz,
    	UPDATED_BY varchar(100)
  );

alter table cfg_pi_project_holidays add constraint unq_cfg_pi_project_holidays unique (project_id,project_holiday_date) enforced;


