use role SYSADMIN;
use warehouse PUREINSIGHTS_DEV_LOAD_DAILY_WH;
use database PUREINSIGHTS_DEV;
use schema PUBLIC;

create or replace view D_PI_WFM_PLANNING_GROUP_CONFIGURATION_VW(
	ID,
	NAME,
	LASTMODIFIEDTIME,
	LASTMODIFIEDDATE,
	PROJECTLASTMODIFIEDTIME,
	PROJECTLASTMODIFIEDDATE,
	BUSINESSUNITID,
	BUSINESSUNITNAME,
	PROJECTID,
	PROJECTNAME,
	PROGRAMID,
	PROGRAMNAME,
	SERVICEGOALTEMPLATEID,
	SERVICEGOALTEMPLATENAME
) COPY GRANTS as
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
  	) 																	AS	PROJECTLASTMODIFIEDDATE,  
	TRIM(CAST(pgc.raw:businessUnitId AS VARCHAR(255))) 					AS	BUSINESSUNITID, 
	bu.businessUnitName													AS	BUSINESSUNITNAME,
	pr.projectId														AS 	PROJECTID,
	pr.projectName														AS 	PROJECTNAME,
	pgc.programId														AS 	PROGRAMID,
	pgc.programName														AS 	PROGRAMNAME,
	TRIM(CAST(pgc.raw:serviceGoalTemplateId AS VARCHAR(255)))			AS	SERVICEGOALTEMPLATEID,
	TRIM(CAST(wsgt.raw:templateName AS VARCHAR(255))) 					AS	SERVICEGOALTEMPLATENAME	
FROM 
	RAW.wfm_planning_group_configuration	pgc
LEFT OUTER JOIN 
	bu 
ON 
(
		pgc.projectid = bu.projectid
	AND	pgc.raw:businessUnitId = bu.id
)
LEFT OUTER JOIN
 	raw.wfm_service_goal_templates wsgt
ON 
(
		pgc.projectid = wsgt.projectid
	AND	pgc.raw:serviceGoalTemplateId = wsgt.raw:templateId
)
INNER JOIN 
	D_PI_PROJECTS pr 
ON 
(
	pgc.projectId = pr.projectId
);

GRANT SELECT ON D_PI_WFM_PLANNING_GROUP_CONFIGURATION_VW TO BI_PRODUCT_DEV;   
GRANT SELECT ON D_PI_WFM_PLANNING_GROUP_CONFIGURATION_VW TO DATA_SUPPORT_ROLE;
GRANT SELECT ON D_PI_WFM_PLANNING_GROUP_CONFIGURATION_VW TO DA_LAB_ADMIN;
GRANT SELECT ON D_PI_WFM_PLANNING_GROUP_CONFIGURATION_VW TO DA_LAB_READ;
GRANT SELECT ON D_PI_WFM_PLANNING_GROUP_CONFIGURATION_VW TO MAX_DEV;
GRANT SELECT ON D_PI_WFM_PLANNING_GROUP_CONFIGURATION_VW TO OPS_ANALYTICS_TEAM;
GRANT SELECT ON D_PI_WFM_PLANNING_GROUP_CONFIGURATION_VW TO PUBLIC;
GRANT SELECT ON D_PI_WFM_PLANNING_GROUP_CONFIGURATION_VW TO INFA_DATA_CATALOG_DEV_READ;
GRANT SELECT ON D_PI_WFM_PLANNING_GROUP_CONFIGURATION_VW TO PUREINSIGHTS_DEV_READ;
GRANT SELECT ON D_PI_WFM_PLANNING_GROUP_CONFIGURATION_VW TO PI_DATA_INGEST_DEV_ALERT_USER;
GRANT DELETE, INSERT, REBUILD, REFERENCES, SELECT, TRUNCATE, UPDATE ON D_PI_WFM_PLANNING_GROUP_CONFIGURATION_VW TO PUREINSIGHTS_DEV_POC;
