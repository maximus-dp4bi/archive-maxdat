CREATE OR REPLACE VIEW "CISCO_ENTERPRISE_CC"."CC_F_IVR_SURVY_BY_DATE_SV" ("SURVEY_DATE", "D_DATE_ID", "QUESTION_NUMBER", "QUESTION", "ANSWER_KEY", "ANSWER_TEXT", "ANSWER_COUNT", "D_PROJECT_ID", "D_PROGRAM_ID") AS 
  SELECT
D.D_DATE AS SURVEY_DATE
, F.D_DATE_ID
, S.QUESTION_NUMBER
, S.QUESTION
, S.ANSWER_KEY
, S.ANSWER_TEXT
, sum (F.RAW_CONTACTS_OFFERED) as ANSWER_COUNT
, Q.D_PROJECT_ID
, Q.D_PROGRAM_ID
FROM CC_F_ACTUALS_QUEUE_INTERVAL F, CC_D_DATES D, CC_C_IVR_SURVEY S, CC_D_CONTACT_QUEUE Q
WHERE F.D_DATE_ID = D.D_DATE_ID
AND F.QUEUE_NUMBER = S.ANSWER_QUEUE_NUMBER
AND F.D_CONTACT_QUEUE_ID = Q.D_CONTACT_QUEUE_ID
GROUP BY D.D_DATE, F.D_DATE_ID, QUESTION_NUMBER, QUESTION, ANSWER_KEY, ANSWER_TEXT, Q.D_PROJECT_ID, Q.D_PROGRAM_ID;



CREATE OR REPLACE VIEW "CISCO_ENTERPRISE_CC"."CC_F_IVR_SURVY_LANG_BY_DATE_SV" ("SURVEY_DATE", "D_DATE_ID", "QUEUE_NUMBER", "SURVEY_LANGUAGE", "CALLS_COUNT", "D_PROJECT_ID", "D_PROGRAM_ID") AS 
SELECT
D.D_DATE AS SURVEY_DATE
, F.D_DATE_ID
, F.QUEUE_NUMBER
, L."LANGUAGE" as SURVEY_LANGUAGE
, sum (F.RAW_CONTACTS_OFFERED) as CALLS_COUNT
, Q.D_PROJECT_ID
, Q.D_PROGRAM_ID
FROM
CC_F_ACTUALS_QUEUE_INTERVAL F , CC_D_DATES D, CC_C_IVR_SURVEY_LANGUAGE L, CC_D_CONTACT_QUEUE Q
WHERE F.D_DATE_ID = D.D_DATE_ID
AND F.QUEUE_NUMBER = L.QUEUE_NUMBER
AND F.D_CONTACT_QUEUE_ID = Q.D_CONTACT_QUEUE_ID
GROUP BY D.D_DATE, F.D_DATE_ID, F.QUEUE_NUMBER, L."LANGUAGE", Q.D_PROJECT_ID, Q.D_PROGRAM_ID;

GRANT SELECT ON CC_F_IVR_SURVY_BY_DATE_SV TO MAXDAT_READ_ONLY;

GRANT SELECT ON CC_F_IVR_SURVY_LANG_BY_DATE_SV TO MAXDAT_READ_ONLY;