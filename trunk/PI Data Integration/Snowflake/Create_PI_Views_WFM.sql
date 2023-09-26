CREATE OR REPLACE VIEW F_PI_WFM_MANAGEMENT_UNIT_CONFIGURATION_VW AS
WITH
 bu AS (SELECT CAST(CO.RAW:id AS VARCHAR (255)) AS businessunitid , CAST(CO.RAW:name AS VARCHAR (255)) AS businessunitname FROM RAW.configuration_objects CO  WHERE CO.RAW:type = 'businessunit'),
 mu AS (SELECT CAST(CO.RAW:id  AS VARCHAR (255)) AS managementunitid , CAST(CO.RAW:name AS VARCHAR (255)) AS managementunitname FROM RAW.configuration_objects CO  WHERE CO.RAW:type = 'managementunit')
SELECT pr.PROJECTID ,
pr.PROJECTNAME ,
MUC.PROGRAMID ,
MUC.PROGRAMNAME ,
bu.businessunitid,
bu.businessunitname,
CAST(MUC.RAW:id  AS VARCHAR (255))as managementUnitId,
CAST(MUC.RAW:name AS VARCHAR (255))as managementUnitName,
CAST(MUC.RAW:startDayOfWeek AS VARCHAR (255)) AS startDayOfWeek ,
CAST(MUC.RAW:startDayOfWeekend AS VARCHAR (255)) AS startDayOfWeekend,
CAST(MUC.RAW:timeZone AS VARCHAR (255)) AS timezone,
CAST(MUC.RAW:divisionId AS VARCHAR (255)) AS divisionId,
CAST(MUC.RAW:adherenceSevereAlertThresholdSeconds AS INT) AS adherenceSevereAlertThresholdSeconds,
CAST(MUC.RAW:adherenceTargetPercent AS INT) AS adherenceTargetPercent,
CAST(MUC.RAW:adherenceExceptionThresholdSeconds AS INT)  AS adherenceExceptionThresholdSeconds,
CAST(MUC.RAW:adherenceNonOnQueueActivitiesEquivalent  AS VARCHAR (255)) AS adherenceNonOnQueueActivitiesEquivalent,
CAST(MUC.RAW:adherenceTrackOnQueueActivity  AS VARCHAR (255)) AS adherenceTrackOnQueueActivity,
CAST(MUC.RAW:adherenceIgnoredActivityCategories  AS VARCHAR (255)) AS adherenceIgnoredActivityCategories
FROM RAW.wfm_management_unit_configuration MUC
join PUBLIC.D_PI_PROJECTS pr
on MUC.projectId = pr.projectId
LEFT OUTER JOIN bu ON MUC.RAW:businessUnitId= bu.businessunitid;




CREATE OR REPLACE VIEW F_PI_WFM_DAY_METRICS_VW AS
with
 u AS (SELECT CAST(CO.RAW:id AS VARCHAR (255)) AS userId , CAST(CO.RAW:name AS VARCHAR (255)) AS userName FROM RAW.configuration_objects CO  WHERE CO.RAW:type = 'user'),
 bu AS (SELECT CAST(CO.RAW:id AS VARCHAR (255)) AS businessunitid , CAST(CO.RAW:name AS VARCHAR (255)) AS businessunitname FROM RAW.configuration_objects CO  WHERE CO.RAW:type = 'businessunit'),
 mu AS (SELECT CAST(CO.RAW:id AS VARCHAR (255)) AS managementunitid , CAST(CO.RAW:name AS VARCHAR (255)) AS managementunitname FROM RAW.configuration_objects CO  WHERE CO.RAW:type = 'managementunit'),
 muConfig AS (SELECT CAST(WMU.RAW:id AS VARCHAR (255)) AS managementunitid , CAST(WMU.RAW:adherenceExceptionThresholdSeconds AS INT) AS adherenceExceptionThresholdSeconds FROM RAW.wfm_management_unit_configuration WMU)
SELECT PR.PROJECTID ,
PR.PROJECTNAME ,
WDM.PROGRAMID ,
WDM.PROGRAMNAME ,
bu.businessunitname AS businessunitname ,
mu.managementunitname,
u.userName,
CAST(WDM.RAW:adherenceScheduleSeconds AS INT) AS adherenceScheduleSeconds,
CAST(WDM.RAW:conformanceScheduleSeconds AS INT) AS conformanceScheduleSeconds,
CAST(WDM.RAW:conformanceActualSeconds  AS INT) AS conformanceActualSeconds,
CAST(WDM.RAW:exceptionCount  AS INT) AS exceptionCount,
CAST(WDM.RAW:scheduleLengthSeconds AS INT) AS scheduleLengthSeconds,
(WDM.RAW:exceptionCount * muConfig.adherenceExceptionThresholdSeconds) + WDM.RAW:exceptionDurationAdherenceSeconds as exceptionDurationSeconds,
CAST(WDM.RAW:exceptionDurationAdherenceSeconds  AS INT) AS exceptionDurationAdherenceSeconds,
CAST(muConfig.adherenceExceptionThresholdSeconds AS INT) AS adherenceExceptionThresholdSeconds,
CAST(WDM.RAW:dayStartTime AS DATETIME) AS dayStartTime,
convert_timezone('UTC',pr.projectTimezone,cast (WDM.RAW:dayStartTime as DATETIME)) as projectdayStartTime,
to_date(convert_timezone('UTC',pr.projectTimezone,cast (WDM.RAW:dayStartTime as DATETIME))) as projectdayStartDate,
CAST(WDM.RAW:userId AS VARCHAR(255)) AS userId,
CAST(WDM.RAW:managementUnitId AS VARCHAR(255)) AS managementUnitId,
CAST(WDM.RAW:businessUnitId AS VARCHAR(255)) AS businessunitId
FROM RAW.wfm_day_metrics WDM
join PUBLIC.D_PI_PROJECTS pr
on WDM.projectId = pr.projectId
LEFT OUTER JOIN bu ON WDM.RAW:businessUnitId= bu.businessunitid
LEFT OUTER JOIN mu ON WDM.RAW:managementUnitId= mu.managementunitid
LEFT OUTER JOIN u ON WDM.RAW:userId=u.userid
LEFT OUTER JOIN muConfig ON WDM.RAW:managementUnitId=muConfig.managementunitid;


CREATE OR REPLACE VIEW F_PI_WFM_ACTIVITY_CODES_VW AS
SELECT pr.PROJECTID ,pr.PROJECTNAME, ac.PROGRAMID, ac.PROGRAMNAME ,
  CAST(AC.RAW:active AS VARCHAR (255)) AS active,
  CAST(AC.RAW:id AS VARCHAR (255)) AS activityCodeid,
  CAST(AC.RAW:name AS VARCHAR (255))  AS activityCodename,
  CAST(AC.RAW:agentTimeOffSelectable AS VARCHAR (255))  AS agentTimeOffSelectable,
  CAST(AC.RAW:businessUnitId AS VARCHAR (255))  AS businessUnitId,
  CAST(AC.RAW:category AS VARCHAR (255))  AS category,
  CAST(AC.RAW:countsAsPaidTime AS VARCHAR (255))  AS countsAsPaidTime,
  CAST(AC.RAW:countsAsWorkTime AS VARCHAR (255))  AS countsAsWorkTime,
  CAST(AC.RAW:defaultCode AS VARCHAR (255)) AS defaultCode,  
  CAST(AC.RAW:lengthInMinutes AS INT) AS lengthInMinutes,
   CAST((AC.RAW:lengthInMinutes * 60) AS INT) AS lengthInSeconds 
FROM RAW.WFM_ACTIVITY_CODES AC
join PUBLIC.D_PI_PROJECTS pr
on AC.projectId = pr.projectId;
