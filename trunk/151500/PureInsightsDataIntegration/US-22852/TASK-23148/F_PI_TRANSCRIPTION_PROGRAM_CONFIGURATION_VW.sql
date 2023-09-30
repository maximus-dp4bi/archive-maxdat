use role SYSADMIN;
use warehouse PUREINSIGHTS_PRD_LOAD_DAILY_WH;
use database PUREINSIGHTS_PRD;
use schema PUBLIC;

create or replace view F_PI_TRANSCRIPTION_PROGRAM_CONFIGURATION_VW(
	PROJECTID,
	PROJECTNAME,
	PROGRAM_ID,
	PROGRAMNAME,
	DESCRIPTION,
	ID,
	NAME,
	PUBLISHED,
	MODIFIEDDATE,
	PROJECTMODIFIEDDATE,
	MODIFIEDBY,
	MODIFIEDBYID,
	PROGRAMDEFAULT
) COPY GRANTS as
WITH
    user AS (SELECT co.projectid AS projectid, co.raw:id AS ID, TRIM(CAST(co.raw:name AS VARCHAR(255))) AS userName FROM raw.configuration_objects co  WHERE co.raw:type = 'user')
Select
  pr.projectId as projectId,
  pr.projectName as projectName,
  rt.programId as program_Id,
  rt.programName as programName,
  CASE	WHEN	LENGTH(TRIM(cast (rt.raw:description as VARCHAR(255)))) = 0  
  		THEN	NULL
  		ELSE	cast (rt.raw:description as VARCHAR(255)) 
  END	as description,
  cast (rt.raw:id as VARCHAR(255)) as id,
  cast (rt.raw:name	as VARCHAR(255)) as name,
  cast (rt.raw:published as BOOLEAN) as published,
  cast (rt.raw:modifiedDate as datetime) as modifieddate,
  convert_timezone('UTC',pr.projectTimezone,cast (rt.raw:modifiedDate as DATETIME)) as projectmodifieddate,   
  USER.userName AS modifiedby,
  cast (rt.raw:modifiedByUserId as varchar(255)) as modifiedbyid,
  cast (rt.raw:default as NUMBER) as programdefault
from RAW.TRANSCRIPTION_PROGRAM_CONFIGURATION rt
LEFT JOIN USER ON rt.projectid = USER.projectid AND rt.raw:modifiedByUserId = USER.id
join PUBLIC.D_PI_PROJECTS pr
on rt.projectId = pr.projectId;

GRANT SELECT ON F_PI_TRANSCRIPTION_PROGRAM_CONFIGURATION_VW TO BI_PRODUCT_DEV;   
GRANT SELECT ON F_PI_TRANSCRIPTION_PROGRAM_CONFIGURATION_VW TO DATA_SUPPORT_ROLE;
GRANT SELECT ON F_PI_TRANSCRIPTION_PROGRAM_CONFIGURATION_VW TO DA_LAB_ADMIN;
GRANT SELECT ON F_PI_TRANSCRIPTION_PROGRAM_CONFIGURATION_VW TO DA_LAB_READ;
GRANT SELECT ON F_PI_TRANSCRIPTION_PROGRAM_CONFIGURATION_VW TO MAX_DEV;
GRANT SELECT ON F_PI_TRANSCRIPTION_PROGRAM_CONFIGURATION_VW TO OPS_ANALYTICS_TEAM;
GRANT SELECT ON F_PI_TRANSCRIPTION_PROGRAM_CONFIGURATION_VW TO PUBLIC;
GRANT SELECT ON F_PI_TRANSCRIPTION_PROGRAM_CONFIGURATION_VW TO INFA_DATA_CATALOG_DEV_READ;
GRANT SELECT ON F_PI_TRANSCRIPTION_PROGRAM_CONFIGURATION_VW TO PUREINSIGHTS_DEV_READ;
GRANT SELECT ON F_PI_TRANSCRIPTION_PROGRAM_CONFIGURATION_VW TO PI_DATA_INGEST_DEV_ALERT_USER;
GRANT DELETE, INSERT, REBUILD, REFERENCES, SELECT, TRUNCATE, UPDATE ON F_PI_TRANSCRIPTION_PROGRAM_CONFIGURATION_VW TO PUREINSIGHTS_DEV_POC;