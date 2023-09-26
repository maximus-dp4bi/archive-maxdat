update corp_etl_clnt_survey_lkup
set survey_question_id = 4398
where survey_column_name = 'PROVREF_PROVIDER_CLINIC_NAME';

commit;