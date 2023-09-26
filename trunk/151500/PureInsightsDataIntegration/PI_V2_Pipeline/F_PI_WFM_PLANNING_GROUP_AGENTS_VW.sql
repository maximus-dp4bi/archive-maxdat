use role SYSADMIN;
use warehouse PUREINSIGHTS_DEV_LOAD_DAILY_WH;
use database PUREINSIGHTS_DEV;
use schema PUBLIC;

create or replace view F_PI_WFM_PLANNING_GROUP_AGENTS_VW COPY GRANTS
(
	PROJECTNAME,
	PROJECTID,
	PROGRAMNAME,
	PROGRAMID,
	USERID,
	USERNAME,
	PLANNINGGROUPID,
	PLANNINGGROUPNAME,
	BUSINESSUNITID,
	BUSINESSUNITNAME
) as
WITH
    u AS (SELECT projectid, CAST(raw:id AS VARCHAR) AS id , CAST(raw:name AS VARCHAR) AS userName FROM RAW.configuration_objects  WHERE raw:type = 'user'),
    pgc AS (SELECT projectid, CAST(raw:id AS VARCHAR) AS id, CAST(raw:name AS VARCHAR) AS planningGroupName, CAST(raw:businessUnitId AS VARCHAR) AS businessUnitId FROM RAW.wfm_planning_group_configuration),
    bu AS (SELECT projectid, CAST(raw:id AS VARCHAR) AS id, CAST(raw:name AS VARCHAR) AS businessUnitName FROM RAW.configuration_objects  WHERE raw:type = 'businessunit')
SELECT
	pr.projectName							AS projectName,
	pr.projectId							AS projectId,
	pga.programName							AS programName,
	pga.programId							AS programId,
	CAST(pga.raw:userId AS VARCHAR)			AS userId,
   	u.userName,
   	CAST(pga.raw:planningGroupId AS VARCHAR)	AS planningGroupId,
   	pgc.planningGroupName,
   	pgc.businessUnitId,
   	bu.businessUnitName
FROM 
	RAW.wfm_planning_group_agents		pga
LEFT OUTER JOIN u ON pga.raw:userId = u.id AND pga.projectid = u.projectid
LEFT OUTER JOIN pgc ON pga.raw:planningGroupId = pgc.id AND pga.projectid = pgc.projectid 
LEFT OUTER JOIN bu ON bu.id = pgc.businessUnitId AND bu.projectid = pgc.projectid
INNER JOIN D_PI_PROJECTS pr ON pga.projectId = pr.projectId;

SELECT * FROM F_PI_WFM_PLANNING_GROUP_AGENTS_VW;



