use role SYSADMIN;
use warehouse PUREINSIGHTS_PRD_LOAD_DAILY_WH;
use database PUREINSIGHTS_PRD;
use schema PUBLIC;

create or replace view D_PI_WFM_PLANNING_GROUP_CONFIGURATION_VW COPY GRANTS AS
WITH
    bu AS (SELECT projectid, CAST(raw:id AS VARCHAR) AS id, CAST(raw:name AS VARCHAR) AS businessUnitName FROM RAW.configuration_objects  WHERE raw:type = 'businessunit')
SELECT
	CAST(pgc.raw:id AS VARCHAR)											AS	ID,
	CAST(pgc.raw:name AS VARCHAR)										AS	NAME,
 	CAST(pgc.raw:dateModified as DATETIME) 								AS 	LASTMODIFIEDTIME,
	to_date
	(
		CAST(pgc.raw:dateModified as DATETIME) 	
	)																	AS 	LASTMODIFIEDDATE,           
	convert_timezone
	(
		'UTC',
		pr.projectTimezone,
		CAST(pgc.raw:dateModified as DATETIME)	
	) 																	AS	PROJECTLASTMODIFIEDTIME,
  	to_date
  	(
  		convert_timezone
  		(
  			'UTC',
  			pr.projectTimezone,
  			cast(pgc.raw:dateModified as DATETIME)
  		)
  	) 												AS	PROJECTLASTMODIFIEDDATE,  
	CAST(pgc.raw:businessUnitId AS VARCHAR) 		AS	BUSINESSUNITID, 
	bu.businessUnitName								AS	BUSINESSUNITNAME,
	pr.projectId									AS 	PROJECTID,
	pr.projectName									AS 	PROJECTNAME,
	pgc.programId									AS 	PROGRAMID,
	pgc.programName									AS 	PROGRAMNAME,
	CAST(pgc.raw:serviceGoalTemplateId AS VARCHAR)	AS	SERVICEGOALTEMPLATEID,
	NULL 											AS	SERVICEGOALTEMPLATENAME	
FROM 
	RAW.wfm_planning_group_configuration	pgc
LEFT OUTER JOIN 
	bu 
ON 
(
		pgc.projectid = bu.projectid
	AND	pgc.raw:businessUnitId = bu.id
)
INNER JOIN 
	D_PI_PROJECTS pr 
ON 
(
	pgc.projectId = pr.projectId
);

SELECT * FROM D_PI_WFM_PLANNING_GROUP_CONFIGURATION_VW;
