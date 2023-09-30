WITH
    bu AS (SELECT  id, name AS businessUnitName FROM raw_configuration_objects  WHERE type = 'businessunit'),
    s AS (SELECT  templateId, templateName FROM raw_wfm_service_goal_templates)
SELECT
    
    config.id,
    name,
    dateModified as lastModifiedTime,
    businessUnitId,
    businessUnitName,
    serviceGoalTemplateId,
    s.templateName as serviceGoalTemplateName
FROM raw_wfm_planning_group_configuration config
    LEFT OUTER JOIN bu ON bu.id = config.businessunitid  
    LEFT OUTER JOIN s on   and config.serviceGoalTemplateId = s.templateId