WITH
    pg AS (SELECT  id, name AS planningGroupName, businessUnitId FROM raw_wfm_planning_group_configuration),
    bu AS (SELECT  id, name AS businessUnitName FROM raw_configuration_objects  WHERE type = 'businessunit'),
    q AS (SELECT  id AS queueId , name AS queueName FROM raw_configuration_objects  WHERE type = 'queue'),
    l AS (SELECT  id AS languageId , name AS languageName FROM raw_configuration_objects  WHERE type = 'language')
SELECT 
       planningGroupId,
       pg.planningGroupName,
       pg.businessUnitId,
       businessUnitName,
       routePathIndex,
       queueName,
       mediaType,
       languageName
FROM raw_wfm_planning_group_route_path_configuration config
         LEFT OUTER JOIN pg ON config.planningGroupId = pg.id  
         LEFT OUTER JOIN bu ON bu.id = pg.businessunitid  
         LEFT OUTER JOIN q ON   AND config.queueId = q.queueId
         LEFT OUTER JOIN l ON   AND config.languageId = l.languageId