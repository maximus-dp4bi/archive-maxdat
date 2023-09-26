WITH
    bu AS (SELECT  id AS businessUnitId , name AS businessUnitName FROM raw_configuration_objects  WHERE type = 'businessunit'),
    u AS (SELECT id , name AS userName FROM raw_configuration_objects  WHERE type = 'user')
SELECT
    
    schedule.scheduleId,
    bu.businessUnitId,
    bu.businessUnitName,
    schedule.week,
    schedule.lastModified as lastModifiedDate,
    u.userName as lastModifiedByUserName,
    u.id as lastModifiedByUserId,
    schedule.version
FROM
    raw_wfm_schedule_details schedule
LEFT OUTER JOIN bu ON schedule.businessUnitId = bu.businessUnitId  
LEFT OUTER JOIN u ON   and schedule.lastModifiedBy = u.id