-- TXEB-2649 new attributes #178 and #179.

Insert into CORP_ETL_CLNT_SURVEY_LKUP (SURVEY_COLUMN_NAME,SURVEY_NAME,SURVEY_QUESTION_ID,SURVEY_QUESTION) values ('CPW_NAME_OF_REFERRER','CPW Referral',3549,'Name of person making Referral');
Insert into CORP_ETL_CLNT_SURVEY_LKUP (SURVEY_COLUMN_NAME,SURVEY_NAME,SURVEY_QUESTION_ID,SURVEY_QUESTION) values ('CPW_REFERRAL_SOURCE_PHONE','CPW Referral',3550,'Phone Number for Person Making Referral');

COMMIT;