WITH u AS (SELECT id , name FROM raw_configuration_objects  WHERE type = 'user')
SELECT 
       u.name,
       raw_user_languages.id as userId,
       languageId,
       languageName,
       proficiency,
       state from raw_user_languages
LEFT OUTER JOIN u ON raw_user_languages.id = u.id