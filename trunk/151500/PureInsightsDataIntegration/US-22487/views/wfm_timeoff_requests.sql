WITH u AS (SELECT  id, name FROM raw_configuration_objects  WHERE type = 'user'),
     mu AS (SELECT id AS managementunitid , name AS managementunitname FROM raw_configuration_objects  WHERE type = 'managementunit'),
     ac AS (SELECT  id AS activityCodeId, name AS activityCodeName, businessUnitId FROM raw_wfm_activity_codes),
     bu AS (SELECT  id AS businessunitid , name AS businessunitname FROM raw_configuration_objects  WHERE type = 'businessunit')
SELECT
    
    bu.businessunitname,
    mu.managementunitname,
    requestId,
    u.name AS userName,
    isFullDayRequest,
    markedAsRead,
    ac.activityCodeName AS activityCode,
    status,
    startTime,
    dailyDurationMinutes,
    notes,
    submitted.name AS submittedBy,
    if(submittedDate > date '2000-01-01' , submittedDate, null ) AS submittedDate,
    reviewed.name AS reviewedBy,
    if(reviewedByDate > date '2000-01-01' , reviewedByDate, null ) AS reviewedDate,
    timeoff.businessunitid as businessUnitId,
    timeoff.managementunitid as managementUnitId,
    timeoff.userId as userId
FROM raw_wfm_timeoff_requests timeoff
         LEFT OUTER JOIN u ON timeoff.userId = u.id  
         LEFT OUTER JOIN u reviewed ON timeoff.reviewedById = reviewed.id  
         LEFT OUTER JOIN u submitted ON timeoff.userId = submitted.id  
         LEFT OUTER JOIN mu ON timeoff.managementunitid= mu.managementunitid  
         LEFT OUTER JOIN ac ON timeoff.activityCodeId = ac.activityCodeId and ac.businessunitid = timeoff.businessunitid  
         LEFT OUTER JOIN bu ON ac.businessunitid= bu.businessunitid =