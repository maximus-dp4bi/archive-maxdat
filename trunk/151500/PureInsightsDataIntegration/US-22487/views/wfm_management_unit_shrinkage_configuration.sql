WITH
    mu AS (SELECT  id AS managementunitid , name AS managementunitname FROM raw_configuration_objects  WHERE type = 'managementunit')
SELECT 
       mu.managementunitname,
       shrinkage.managementUnitId,
       dayOfWeek,
       intervalStart12h as intervalStart12HourFormat,
       intervalStart24h as intervalStart24HourFormat,
       intervalStartDayIndex,
       shrinkagePercent
FROM raw_wfm_management_unit_shrinkage_configuration AS shrinkage
 INNER JOIN mu ON   AND shrinkage.managementunitid= mu.managementunitid