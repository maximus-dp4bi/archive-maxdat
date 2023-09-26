use schema public;

create table cfg_pi_project_hours (
	PROJECT_ID varchar(255) not null,
	PROJECT_NAME varchar(255) not null,
	PROJECT_TIME_ZONE varchar(255) not null,
	PROJECT_HOURS_START_TIME varchar(10) not null,
	PROJECT_HOURS_END_TIME varchar(10) not null,
	PROJECT_HOURS_START_DAY number(1) not null,
	PROJECT_HOURS_END_DAY number(1) not null,
    	CREATED_AT timestamp_tz,
    	CREATED_BY varchar(255),
    	UPDATED_AT timestamp_tz,
    	UPDATED_BY varchar(255)
  );

