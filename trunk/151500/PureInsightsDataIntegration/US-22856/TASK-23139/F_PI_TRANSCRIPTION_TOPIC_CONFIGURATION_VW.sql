use role SYSADMIN;
use warehouse PUREINSIGHTS_PRD_LOAD_DAILY_WH;
use database PUREINSIGHTS_PRD;
use schema PUBLIC;

create or replace view F_PI_TRANSCRIPTION_TOPIC_CONFIGURATION_VW(
	PROJECTID,
	PROJECTNAME,
	PROGRAM_ID,
	PROGRAMNAME,
	DESCRIPTION,
	DIALECT,
	ID,
	NAME,
	PARTICIPANTS,
	PUBLISHED,
	STRICTNESS,
	MODIFIEDDATE,
	PROJECTMODIFIEDDATE,
	PUBLISHEDDATE,
	PROJECTPUBLISHEDDATE,
	MODIFIEDBY,
	MODIFIEDBYID,
	PUBLISHEDBY,
	PUBLISHEDBYID
) COPY GRANTS as
WITH
    user_mod AS (SELECT co.projectid AS projectid, co.raw:id AS ID, TRIM(CAST(co.raw:name AS VARCHAR(255))) AS name FROM raw.configuration_objects co  WHERE co.raw:type = 'user'),
    user_pub AS (SELECT co.projectid AS projectid, co.raw:id AS ID, TRIM(CAST(co.raw:name AS VARCHAR(255))) AS name FROM raw.configuration_objects co  WHERE co.raw:type = 'user')    
Select
  rt.projectId as projectId,
  rt.projectName as projectName,
  rt.programId as program_Id,
  rt.programName as programName,
  CASE	WHEN	LENGTH(TRIM(cast (rt.raw:description as VARCHAR(255)))) = 0  
  		THEN	NULL
  		ELSE	cast (rt.raw:description as VARCHAR(255)) 
  END	as description,
  cast (rt.raw:dialect as VARCHAR(255)) as dialect,
  cast (rt.raw:id as VARCHAR(255)) as id,
  cast (rt.raw:name as VARCHAR(255)) as name,
  cast (rt.raw:participants as VARCHAR(255)) as participants,
  cast (rt.raw:published as BOOLEAN) as published,
  cast (rt.raw:strictness as INT) as strictness,
  cast (rt.raw:modifiedDate as datetime) as modifieddate,
  convert_timezone('UTC',pr.projectTimezone,cast (rt.raw:modifiedDate as DATETIME)) as projectmodifieddate,
  cast (rt.raw:publishedDate as datetime) as publisheddate,
  convert_timezone('UTC',pr.projectTimezone,cast (rt.raw:publishedDate as DATETIME)) as projectpublisheddate,
  user_mod.NAME AS modifiedby,
  cast (rt.raw:modifiedByUserId as varchar(255)) as modifiedbyid,
  user_pub.NAME AS publishedby,
  cast (rt.raw:publishedByUserId as varchar(255)) as publishedbyid
from "RAW"."TRANSCRIPTION_TOPIC_CONFIGURATION" rt
join PUBLIC.D_PI_PROJECTS pr
on rt.projectId = pr.projectId
LEFT JOIN user_mod
ON rt.projectid = user_mod.projectid AND rt.raw:modifiedByUserId = user_mod.id
LEFT JOIN user_pub
ON rt.projectid = user_pub.projectid AND rt.raw:publishedByUserId = user_pub.id;

GRANT SELECT ON F_PI_TRANSCRIPTION_TOPIC_CONFIGURATION_VW TO BI_PRODUCT_DEV;   
GRANT SELECT ON F_PI_TRANSCRIPTION_TOPIC_CONFIGURATION_VW TO DATA_SUPPORT_ROLE;
GRANT SELECT ON F_PI_TRANSCRIPTION_TOPIC_CONFIGURATION_VW TO DA_LAB_ADMIN;
GRANT SELECT ON F_PI_TRANSCRIPTION_TOPIC_CONFIGURATION_VW TO DA_LAB_READ;
GRANT SELECT ON F_PI_TRANSCRIPTION_TOPIC_CONFIGURATION_VW TO MAX_DEV;
GRANT SELECT ON F_PI_TRANSCRIPTION_TOPIC_CONFIGURATION_VW TO OPS_ANALYTICS_TEAM;
GRANT SELECT ON F_PI_TRANSCRIPTION_TOPIC_CONFIGURATION_VW TO PUBLIC;
GRANT SELECT ON F_PI_TRANSCRIPTION_TOPIC_CONFIGURATION_VW TO INFA_DATA_CATALOG_DEV_READ;
GRANT SELECT ON F_PI_TRANSCRIPTION_TOPIC_CONFIGURATION_VW TO PUREINSIGHTS_DEV_READ;
GRANT SELECT ON F_PI_TRANSCRIPTION_TOPIC_CONFIGURATION_VW TO PI_DATA_INGEST_DEV_ALERT_USER;
GRANT DELETE, INSERT, REBUILD, REFERENCES, SELECT, TRUNCATE, UPDATE ON F_PI_TRANSCRIPTION_TOPIC_CONFIGURATION_VW TO PUREINSIGHTS_DEV_POC;

SELECT * FROM F_PI_TRANSCRIPTION_TOPIC_CONFIGURATION_VW;
