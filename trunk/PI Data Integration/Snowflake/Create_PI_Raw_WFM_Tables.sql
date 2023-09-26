create or replace TABLE RAW.WFM_MANAGEMENT_UNIT_CONFIGURATION(
	PROJECTID VARCHAR(255),
	PROJECTNAME VARCHAR(255),
	PROGRAMID VARCHAR(255),
	PROGRAMNAME VARCHAR(255),
	RAW VARIANT,
	INGESTIONDATETIME TIMESTAMP_NTZ(9)
);

create or replace TABLE RAW.WFM_DAY_METRICS (
	PROJECTID VARCHAR(255),
	PROJECTNAME VARCHAR(255),
	PROGRAMID VARCHAR(255),
	PROGRAMNAME VARCHAR(255),
	RAW VARIANT,
	INGESTIONDATETIME TIMESTAMP_NTZ(9)
);

insert into PUBLIC.d_pi_tables values ('wfm_day_metrics',true,true,current_timestamp());
insert into PUBLIC.d_pi_tables values ('wfm_management_unit_configuration',true,true,current_timestamp());
COMMIT;

--CALL BELOW SP TO MAKE AN ENTRY INTO PUBLIC.d_pi_PROJECT_unavailable_tables for which these tables data is not available. 

 call raw.configurePIUnavailableTables('9999');
 call raw.configurePIUnavailableTables('6666');
 call raw.configurePIUnavailableTables('3333');
 call raw.configurePIUnavailableTables('741');
 call raw.configurePIUnavailableTables('701');
 call raw.configurePIUnavailableTables('8888');
 call raw.configurePIUnavailableTables('5555');
 call raw.configurePIUnavailableTables('4444');
 call raw.configurePIUnavailableTables('2222');
 call raw.configurePIUnavailableTables('1111');
 call raw.configurePIUnavailableTables('601');
 call raw.configurePIUnavailableTables('201');
 call raw.configurePIUnavailableTables('621');
 call raw.configurePIUnavailableTables('301');
 call raw.configurePIUnavailableTables('101');
