WITH
    bu AS (SELECT  id, name AS businessUnitName FROM raw_configuration_objects  WHERE type = 'businessunit'),
    user AS (SELECT  id, name AS userName FROM raw_configuration_objects  WHERE type = 'user')
SELECT
    
    includeServiceLevel,
    serviceLevelPercent,
    serviceLevelSeconds,
    templateId,
    templateName,
    businessUnitID,
    businessUnitName,
    includeAverageSpeedOfAnswer,
    averageSpeedOfAnswerSeconds,
    includeAbandonRate,
    abandonRatePercent,
    version,
    modifiedByUserId,
    userName as modifiedByUserName,
    dateModified
FROM raw_wfm_service_goal_templates templates
    LEFT OUTER JOIN bu ON templates.businessunitid = bu.id  
    LEFT OUTER JOIN user ON templates.modifiedByUserId = user.id