use role SYSADMIN;
use warehouse PUREINSIGHTS_DEV_LOAD_DAILY_WH;
use database PUREINSIGHTS_DEV;
use schema PUBLIC;

CREATE OR REPLACE VIEW D_PI_WFM_SERVICE_GOAL_TEMPLATES_VW COPY GRANTS AS
WITH
    bu AS (SELECT co.projectid AS projectid, co.raw:id AS ID, TRIM(CAST(co.raw:name AS VARCHAR(255))) AS businessUnitName FROM raw.configuration_objects co  WHERE co.raw:type = 'businessunit'),
    user AS (SELECT co.projectid AS projectid, co.raw:id AS ID, TRIM(CAST(co.raw:name AS VARCHAR(255))) AS userName FROM raw.configuration_objects co  WHERE co.raw:type = 'user')
SELECT    
	pr.projectid													AS	projectid,
	pr.projectname													AS	projectname,
	t.programid														AS	programid,
	t.programname													AS	programname,
	CAST(t.raw:includeServiceLevel AS INTEGER)						AS	includeServiceLevel,
    CAST(t.raw:serviceLevelPercent AS INTEGER)						AS	serviceLevelPercent,
    CAST(t.raw:serviceLevelSeconds AS INTEGER)						AS	serviceLevelSeconds,
    TRIM(CAST(t.raw:templateId AS VARCHAR(255)))					AS	templateId,
    TRIM(CAST(t.raw:templateName AS VARCHAR(255)))					AS	templateName,
    TRIM(CAST(t.raw:businessUnitId AS VARCHAR(255)))				AS	businessUnitId,
    bu.businessUnitName												AS	businessUnitName,
    CAST(t.raw:includeAverageSpeedOfAnswer AS INTEGER)				AS	includeAverageSpeedOfAnswer,
    CAST(t.raw:averageSpeedOfAnswerSeconds AS INTEGER)				AS	averageSpeedOfAnswerSeconds,
    CAST(t.raw:includeAbandonRate AS INTEGER)						AS	includeAbandonRate,
    CAST(t.raw:abandonRatePercent AS INTEGER)						AS	abandonRatePercent,
    CAST(t.raw:version AS INTEGER)									AS	version,
    TRIM(CAST(t.raw:modifiedByUserId AS VARCHAR(255)))				AS	modifiedByUserId,
    user.userName													AS 	modifiedByUserName,
  	CAST(t.raw:dateModified as DATETIME) 							AS 	dateTimeModified,
  	to_date(CAST(t.raw:dateModified as DATETIME)) 					AS 	dateModified,	
  	convert_timezone('UTC',pr.projectTimezone,
  					 CAST(t.raw:dateModified as DATETIME)) 			AS 	projectDateTimeModified,
  	to_date(convert_timezone('UTC',pr.projectTimezone,
  							CAST(t.raw:dateModified as DATETIME)))	AS	projectDateModified
FROM raw.wfm_service_goal_templates T
	INNER JOIN D_PI_PROJECTS pr ON T.projectid = pr.projectid
    LEFT OUTER JOIN bu ON t.projectid = bu.projectid AND t.raw:businessUnitId = bu.id  
    LEFT OUTER JOIN user ON t.projectid = user.projectid AND t.raw:modifiedByUserId = user.id;

GRANT SELECT ON D_PI_WFM_SERVICE_GOAL_TEMPLATES_VW TO BI_PRODUCT_DEV;   
GRANT SELECT ON D_PI_WFM_SERVICE_GOAL_TEMPLATES_VW TO DATA_SUPPORT_ROLE;
GRANT SELECT ON D_PI_WFM_SERVICE_GOAL_TEMPLATES_VW TO DA_LAB_ADMIN;
GRANT SELECT ON D_PI_WFM_SERVICE_GOAL_TEMPLATES_VW TO DA_LAB_READ;
GRANT SELECT ON D_PI_WFM_SERVICE_GOAL_TEMPLATES_VW TO MAX_DEV;
GRANT SELECT ON D_PI_WFM_SERVICE_GOAL_TEMPLATES_VW TO OPS_ANALYTICS_TEAM;
GRANT SELECT ON D_PI_WFM_SERVICE_GOAL_TEMPLATES_VW TO PUBLIC;
GRANT SELECT ON D_PI_WFM_SERVICE_GOAL_TEMPLATES_VW TO INFA_DATA_CATALOG_DEV_READ;
GRANT SELECT ON D_PI_WFM_SERVICE_GOAL_TEMPLATES_VW TO PUREINSIGHTS_DEV_READ;
GRANT SELECT ON D_PI_WFM_SERVICE_GOAL_TEMPLATES_VW TO PI_DATA_INGEST_DEV_ALERT_USER;
GRANT DELETE, INSERT, REBUILD, REFERENCES, SELECT, TRUNCATE, UPDATE ON D_PI_WFM_SERVICE_GOAL_TEMPLATES_VW TO PUREINSIGHTS_DEV_POC;

SELECT * FROM D_PI_WFM_SERVICE_GOAL_TEMPLATES_VW;
