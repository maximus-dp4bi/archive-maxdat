use role SYSADMIN;
use warehouse PUREINSIGHTS_UAT_LOAD_DAILY_WH;
use database PUREINSIGHTS_UAT;
use schema PUBLIC;

create or replace view D_PI_USER_LANGUAGES_VW(
	NAME,
	USERID,
	LANGUAGEID,
	LANGUAGENAME,
	PROFICIENCY,
	STATE,
	PROJECTID,
	PROJECTNAME,
	PROGRAMID,
	PROGRAMNAME
) COPY GRANTS as
select cast(ul.raw:name as varchar) as name,
cast(ul.raw:id as varchar) as userId,
cast(ul.raw:languageID as varchar) as languageId,
cast(ul.raw:languageName as varchar) as languageName,
cast(ul.raw:proficiency as integer) as proficiency,
cast(ul.raw:state as varchar) as state,
cast(pr.projectid as varchar) as projectId,
cast(pr.projectName as varchar) as projectName,
cast(ul.programId as varchar) as programId,
cast(ul.programName as varchar) as programName
from RAW.user_languages ul
inner join PUBLIC.D_PI_PROJECTS pr
on ul.projectId = pr.projectId;

GRANT SELECT ON D_PI_USER_LANGUAGES_VW TO BI_PRODUCT_DEV;   
GRANT SELECT ON D_PI_USER_LANGUAGES_VW TO DATA_SUPPORT_ROLE;
GRANT SELECT ON D_PI_USER_LANGUAGES_VW TO DA_LAB_ADMIN;
GRANT SELECT ON D_PI_USER_LANGUAGES_VW TO DA_LAB_READ;
GRANT SELECT ON D_PI_USER_LANGUAGES_VW TO MAX_DEV;
GRANT SELECT ON D_PI_USER_LANGUAGES_VW TO OPS_ANALYTICS_TEAM;
GRANT SELECT ON D_PI_USER_LANGUAGES_VW TO PUBLIC;
GRANT SELECT ON D_PI_USER_LANGUAGES_VW TO INFA_DATA_CATALOG_DEV_READ;
GRANT SELECT ON D_PI_USER_LANGUAGES_VW TO PUREINSIGHTS_DEV_READ;
GRANT SELECT ON D_PI_USER_LANGUAGES_VW TO PI_DATA_INGEST_DEV_ALERT_USER;
GRANT DELETE, INSERT, REBUILD, REFERENCES, SELECT, TRUNCATE, UPDATE ON D_PI_USER_LANGUAGES_VW TO PUREINSIGHTS_DEV_POC;

SELECT * FROM D_PI_USER_LANGUAGES_VW;
