WITH
    u AS (SELECT id , name AS userName FROM raw_configuration_objects  WHERE type = 'user'),
    wp AS (SELECT  id, name AS workplanName FROM raw_wfm_work_plan_configuration),
    wpr AS (SELECT  id, name AS workplanRotationName FROM raw_wfm_work_plan_rotation_configuration),
    mu AS (SELECT  id AS managementUnitId , name AS managementUnitName FROM raw_configuration_objects  WHERE type = 'managementunit')
SELECT 
       userId,
       userName,
       workplanName,
       workplanRotationName,
       raw_wfm_management_unit_agents.managementUnitId,
       managementUnitName,
       acceptDirectShiftTrades,
       schedulable
FROM raw_wfm_management_unit_agents
         LEFT OUTER JOIN u ON raw_wfm_management_unit_agents.userid = u.id  
         LEFT OUTER JOIN wp ON raw_wfm_management_unit_agents.workplanid = wp.id  
         LEFT OUTER JOIN wpr ON raw_wfm_management_unit_agents.workplanrotationid = wpr.id  
         LEFT OUTER JOIN mu ON =  and raw_wfm_management_unit_agents.managementunitid= mu.managementunitid