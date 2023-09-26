use role SYSADMIN;
use warehouse PUREINSIGHTS_DEV_LOAD_DAILY_WH;
use database PUREINSIGHTS_DEV;
use schema PUBLIC;

create or replace view D_PI_TEAMS_MEMBERSHIP_VW(
	PROJECTID,
	PROJECTNAME,
	PROGRAMID,
	PROGRAMNAME,
	TEAMID,
	TEAMNAME,
	USERID,
	USERNAME,
	DIVISIONID,
	DIVISIONNAME,
	RAW,
	INGESTIONDATETIME		
) COPY GRANTS as
WITH u AS (SELECT raw:id AS userid , raw:name AS userName, raw:DivisionId AS divisionId, raw:DivisionName AS divisionName, projectid as projectid FROM raw.configuration_objects  WHERE raw:type = 'user'),
t AS (SELECT raw:id AS teamid , raw:name AS teamname, projectid as projectid FROM raw.configuration_objects  WHERE raw:type = 'team')
SELECT
  tm.projectId as projectId,
  tm.projectName as projectName,
  tm.programId as programId,
  tm.programName as programName,
  cast (t.teamid as VARCHAR(255)) as teamId,
  cast (t.teamname as VARCHAR(255)) as teamName,
  cast (u.userid as VARCHAR(255)) as userId,
  cast (u.userName as VARCHAR(255)) as userName,
  cast (u.divisionId as VARCHAR(255)) as divisionId,
  cast (u.divisionName as VARCHAR(255)) as divisionName,
  RAW,
  INGESTIONDATETIME  
FROM raw.teams_membership tm
LEFT OUTER JOIN t ON tm.raw:name = t.teamid and tm.projectid = t.projectid 
LEFT OUTER JOIN u ON tm.raw:userId = u.userid and tm.projectid = u.projectid

GRANT SELECT ON D_PI_TEAMS_MEMBERSHIP_VW TO BI_PRODUCT_DEV;   
GRANT SELECT ON D_PI_TEAMS_MEMBERSHIP_VW TO DATA_SUPPORT_ROLE;
GRANT SELECT ON D_PI_TEAMS_MEMBERSHIP_VW TO DA_LAB_ADMIN;
GRANT SELECT ON D_PI_TEAMS_MEMBERSHIP_VW TO DA_LAB_READ;
GRANT SELECT ON D_PI_TEAMS_MEMBERSHIP_VW TO MAX_DEV;
GRANT SELECT ON D_PI_TEAMS_MEMBERSHIP_VW TO OPS_ANALYTICS_TEAM;
GRANT SELECT ON D_PI_TEAMS_MEMBERSHIP_VW TO PUBLIC;
GRANT SELECT ON D_PI_TEAMS_MEMBERSHIP_VW TO INFA_DATA_CATALOG_DEV_READ;
GRANT SELECT ON D_PI_TEAMS_MEMBERSHIP_VW TO PUREINSIGHTS_DEV_READ;
GRANT SELECT ON D_PI_TEAMS_MEMBERSHIP_VW TO PI_DATA_INGEST_DEV_ALERT_USER;
GRANT DELETE, INSERT, REBUILD, REFERENCES, SELECT, TRUNCATE, UPDATE ON D_PI_TEAMS_MEMBERSHIP_VW TO PUREINSIGHTS_DEV_POC;

