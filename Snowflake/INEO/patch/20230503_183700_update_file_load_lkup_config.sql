INSERT INTO file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file,derive_timestamp_stmt,file_day_received,current_table_name,current_table_primary_key,full_load_table_primary_key) 
 VALUES('QUAL_METRIC_SCORECARDS_','INEO_QUALITY_METRIC_SCORECARDS_HISTORY','INEO',
'autonumber,region,supervisor,manager,qisc,status,score,filename,supervisor_name,qisc_name,qi_supervisor_name,regional_supervisors,generate_pdf,send_to_trash,employee_id,fssa_id,art_id,employee_name,submitted_employee_name,training_status,fssa_email,qi_supervisor,record_id,scoring_date,points_earned,points_possible,deduction_received,task_sequence_number,
cp_1a,cp_1b,cp_1c,cp_1d,cp_1e,cp_1f,cp_1g,cp_1h,cp_1i,cp_1j,cp_1applicable,cp_1score,cp_1comments,cp_2a,cp_2b,cp_2applicable,cp_2score,cp_2comments,
cp_3a,cp_3b,cp_3c,cp_3d,cp_3e,cp_3f,cp_3applicable,cp_3score,cp_3comments,cp_4a,cp_4b,cp_4c,cp_4d,cp_4e,cp_4f,cp_4applicable,cp_4score,cp_4comments,
cp_5a,cp_5b,cp_5c,cp_5d,cp_5e,cp_5f,cp_5g,cp_5h,cp_5i,cp_5j,cp_5k,cp_5l,cp_5applicable,cp_5score,cp_5comments,cp_6a,cp_6b,cp_6c,cp_6d,cp_6applicable,cp_6score,cp_6comments,
cp_7a,cp_7b,cp_7c,cp_7d,cp_7e,cp_7f,cp_7g,cp_7h,cp_7applicable,cp_7score,cp_7comments,cp_8a,cp_8b,cp_8c,cp_8applicable,cp_8score,cp_8comments,
cp_9a,cp_9b,cp_9c,cp_9d,cp_9e,cp_9f,cp_9g,cp_9h,cp_9i,cp_9j,cp_9k,cp_9applicable,cp_9score,cp_9comments,cp_10a,cp_10b,cp_10c,cp_10d,cp_10e,cp_10f,cp_10g,cp_10h,cp_10i,cp_10applicable,cp_10score,cp_10comments,
cp_11a,cp_11b,cp_11c,cp_11d,cp_11e,cp_11f,cp_11g,cp_11h,cp_11applicable,cp_11score,cp_11comments,cp_12a,cp_12b,cp_12c,cp_12d,cp_12e,cp_12f,cp_12g,cp_12h,cp_12i,cp_12applicable,cp_12score,cp_12comments,
cp_13a,cp_13applicable,cp_13score,cp_13comments,cp_14a,cp_14applicable,cp_14score,cp_14comments,
cp_15a,cp_15b,cp_15c,cp_15applicable,cp_15score,cp_15comments,cp_16a,cp_16b,cp_16applicable,cp_16score,cp_16comments,cp_17a,cp_17b,cp_17c,cp_17d,cp_17e,cp_17f,cp_17applicable,cp_17score,cp_17comments,
cp_18a,cp_18applicable,cp_18score,cp_18comments,cp_19a,cp_19applicable,cp_19score,cp_19comments,cp_20a,cp_20b,cp_20applicable,cp_20score,cp_20comments,cp_21a,cp_21b,cp_21applicable,cp_21score,cp_21comments,
cp_22a,cp_22applicable,cp_22score,cp_22comments,cp_23a,cp_23applicable,cp_23score,cp_23comments,cp_24a,cp_24applicable,cp_24score,cp_24comments,
cp_25a,cp_25b,cp_25applicable,cp_25score,cp_25comments,cp_26a,cp_26b,cp_26c,cp_26applicable,cp_26score,cp_26comments,cp_27a,cp_27applicable,cp_27score,cp_27comments,
cp_28a,cp_28b,cp_28c,cp_28d,cp_28e,cp_28f,cp_28applicable,cp_28score_percent_deduction,cp_28comments,overall_comments',
'autonumber,region,supervisor,manager,qisc,status,TRY_CAST(score AS FLOAT),filename,supervisor_name,qisc_name,qi_supervisor_name,regional_supervisors,generate_pdf,send_to_trash,employee_id,fssa_id,art_id,employee_name,submitted_employee_name,training_status,fssa_email,qi_supervisor,record_id,scoring_date,points_earned,points_possible,TRY_CAST(deduction_received AS FLOAT),task_sequence_,
cp_1a,cp_1b,cp_1c,cp_1d,cp_1e,cp_1f,cp_1g,cp_1h,cp_1i,cp_1j,cp_1applicable,TRY_CAST(cp_1score AS NUMBER),cp_1comments,cp_2a,cp_2b,cp_2applicable,TRY_CAST(cp_2score AS NUMBER),cp_2comments,
cp_3a,cp_3b,cp_3c,cp_3d,cp_3e,cp_3f,cp_3applicable,TRY_CAST(cp_3score AS NUMBER),cp_3comments,cp_4a,cp_4b,cp_4c,cp_4d,cp_4e,cp_4f,cp_4applicable,TRY_CAST(cp_4score AS NUMBER),cp_4comments,
cp_5a,cp_5b,cp_5c,cp_5d,cp_5e,cp_5f,cp_5g,cp_5h,cp_5i,cp_5j,cp_5k,cp_5l,cp_5applicable,TRY_CAST(cp_5score AS NUMBER),cp_5comments,cp_6a,cp_6b,cp_6c,cp_6d,cp_6applicable,TRY_CAST(cp_6score AS NUMBER),cp_6comments,
cp_7a,cp_7b,cp_7c,cp_7d,cp_7e,cp_7f,cp_7g,cp_7h,cp_7applicable,TRY_CAST(cp_7score AS NUMBER),cp_7comments,cp_8a,cp_8b,cp_8c,cp_8applicable,TRY_CAST(cp_8score AS NUMBER),cp_8comments,
cp_9a,cp_9b,cp_9c,cp_9d,cp_9e,cp_9f,cp_9g,cp_9h,cp_9i,cp_9j,cp_9k,cp_9applicable,TRY_CAST(cp_9score AS NUMBER),cp_9comments,cp_10a,cp_10b,cp_10c,cp_10d,cp_10e,cp_10f,cp_10g,cp_10h,cp_10i,cp_10applicable,TRY_CAST(cp_10score AS NUMBER),cp_10comments,
cp_11a,cp_11b,cp_11c,cp_11d,cp_11e,cp_11f,cp_11g,cp_11h,cp_11applicable,TRY_CAST(cp_11score AS NUMBER),cp_11comments,cp_12a,cp_12b,cp_12c,cp_12d,cp_12e,cp_12f,cp_12g,cp_12h,cp_12i,cp_12applicable,TRY_CAST(cp_12score AS NUMBER),cp_12comments,
cp_13a,cp_13applicable,TRY_CAST(cp_13score AS NUMBER),cp_13comments,cp_14a,cp_14applicable,TRY_CAST(cp_14score AS NUMBER),cp_14comments,
cp_15a,cp_15b,cp_15c,cp_15applicable,TRY_CAST(cp_15score AS NUMBER),cp_15comments,cp_16a,cp_16b,cp_16applicable,TRY_CAST(cp_16score AS NUMBER),cp_16comments,
cp_17a,cp_17b,cp_17c,cp_17d,cp_17e,cp_17f,cp_17applicable,TRY_CAST(cp_17score AS NUMBER),cp_17comments,cp_18a,cp_18applicable,TRY_CAST(cp_18score AS NUMBER),cp_18comments,
cp_19a,cp_19applicable,TRY_CAST(cp_19score AS NUMBER),cp_19comments,cp_20a,cp_20b,cp_20applicable,TRY_CAST(cp_20score AS NUMBER),cp_20comments,
cp_21a,cp_21b,cp_21applicable,TRY_CAST(cp_21score AS NUMBER),cp_21comments,cp_22a,cp_22applicable,TRY_CAST(cp_22score AS NUMBER),cp_22comments,
cp_23a,cp_23applicable,TRY_CAST(cp_23score AS NUMBER),cp_23comments,cp_24a,cp_24applicable,TRY_CAST(cp_24score AS NUMBER),cp_24comments,
cp_25a,cp_25b,cp_25applicable,TRY_CAST(cp_25score AS NUMBER),cp_25comments,cp_26a,cp_26b,cp_26c,cp_26applicable,TRY_CAST(cp_26score AS NUMBER),cp_26comments,
cp_27a,cp_27applicable,TRY_CAST(cp_27score AS NUMBER),cp_27comments,cp_28a,cp_28b,cp_28c,cp_28d,cp_28e,cp_28f,cp_28applicable,TRY_CAST(cp_28score AS FLOAT),cp_28comments,overall_comments',
'WHERE 1=1',
'Y',
'SELECT TO_CHAR(TO_TIMESTAMP(TRIM(SUBSTR(<filename>,LENGTH(<filename>)-13)),''yyyymmddhh24miss''),''mm/dd/yyyy hh24:mi:ss'') file_date,''Y'' with_timestamp FROM dual',
'PREVIOUS_BUSINESS_DAY', NULL,NULL,'QUAL_METRIC_SCORECARDS_ID');

INSERT INTO file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file,derive_timestamp_stmt,file_day_received,current_table_name,current_table_primary_key,full_load_table_primary_key) 
 VALUES('WMST_QA_BY_REGION_','INEO_WMST_QA_BY_REGION_HISTORY','INEO',
'year,january,february,march,april,may,june,july,august,september,october,november,december,filename,region_name,cumulative_rate',
'TRY_CAST(year AS NUMBER),TRY_CAST(january AS NUMBER) ,TRY_CAST(february AS NUMBER),TRY_CAST(march AS NUMBER),TRY_CAST(april AS NUMBER),TRY_CAST(may AS NUMBER),TRY_CAST(june AS NUMBER),TRY_CAST(july AS NUMBER),
TRY_CAST(august AS NUMBER),TRY_CAST(september AS NUMBER),TRY_CAST(october AS NUMBER),TRY_CAST(november AS NUMBER),TRY_CAST(december AS NUMBER),filename,region_name,TRY_CAST(cumulative_rate AS NUMBER)',
'WHERE 1=1',
'Y',
'SELECT TO_CHAR(TO_TIMESTAMP(TRIM(SUBSTR(<filename>,LENGTH(<filename>)-13)),''mmddyyyyhh24miss''),''mm/dd/yyyy hh24:mi:ss'') file_date,''Y'' with_timestamp FROM dual',
'PREVIOUS_BUSINESS_DAY',null,null,'WMST_QA_BY_REGION_ID');

INSERT INTO file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file,derive_timestamp_stmt,file_day_received,current_table_name,current_table_primary_key,full_load_table_primary_key) 
 VALUES('WMST_USER_QA_SCORES_','INEO_WMST_USER_QA_SCORES_HISTORY','INEO',
'metric,filename,record_id,task_name,review_completion_date,total_possible_earned,maximum_possible_points,total_percentage_score,e2e_deduction,final_percentage_score',
'metric,filename,record_id,task_name,TRY_CAST(review_completion_date AS DATE),TRY_CAST(total_possible_earned AS NUMBER),TRY_CAST(maximum_possible_points AS NUMBER),
 TRY_CAST(total_percentage_score AS FLOAT),TRY_CAST(e2e_deduction AS FLOAT),TRY_CAST(final_percentage_score AS FLOAT)',
'WHERE 1=1',
'Y',
'SELECT TO_CHAR(TO_TIMESTAMP(TRIM(SUBSTR(<filename>,LENGTH(<filename>)-13)),''mmddyyyyhh24miss''),''mm/dd/yyyy hh24:mi:ss'') file_date,''Y'' with_timestamp FROM dual',
'PREVIOUS_BUSINESS_DAY',null,null,'WMST_USER_QA_SCORES_ID');

INSERT INTO file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file,derive_timestamp_stmt,file_day_received,current_table_name,current_table_primary_key,full_load_table_primary_key) 
 VALUES('WMST_USER_CUMULATIVE_REVIEWS_','INEO_WMST_USER_CUMULATIVE_REVIEWS_HISTORY','INEO',
'caseworker,region,office,filename,user_id,cumulative_number,number_of_reviews',
'caseworker,region,office,filename,user_id,TRY_CAST(cumulative_ AS NUMBER),TRY_CAST(number_of_reviews AS NUMBER)',
'WHERE 1=1',
'Y',
'SELECT TO_CHAR(TO_TIMESTAMP(TRIM(SUBSTR(<filename>,LENGTH(<filename>)-13)),''mmddyyyyhh24miss''),''mm/dd/yyyy hh24:mi:ss'') file_date,''Y'' with_timestamp FROM dual',
'PREVIOUS_BUSINESS_DAY',null,null,'WMST_USER_CUMULATIVE_REVIEWS_ID');

INSERT INTO file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file,derive_timestamp_stmt,file_day_received,current_table_name,current_table_primary_key,full_load_table_primary_key) 
 VALUES('WMST_MONTHLY_METRIC_TOTALS_','INEO_WMST_MONTHLY_METRIC_TOTALS_HISTORY','INEO',
'metric,filename,number_of_reviews_completed,total_possible_points_earned,total_maximum_possible_points,total_final_percentage_score',
'metric,filename,TRY_CAST(number_of_reviews_completed AS NUMBER),TRY_CAST(REGEXP_REPLACE(total_possible_points_earned,''[^0-9]'','''') AS NUMBER) total_possible_points_earned,
TRY_CAST(REGEXP_REPLACE(total_maximum_possible_points,''[^0-9]'','''') AS NUMBER) total_maximum_possible_points,TRY_CAST(REGEXP_REPLACE(total_final_percentage_score,''[^0-9]'','''') AS NUMBER) total_final_percentage_score',
'WHERE 1=1',
'Y',
'SELECT TO_CHAR(TO_TIMESTAMP(TRIM(SUBSTR(<filename>,LENGTH(<filename>)-13)),''mmddyyyyhh24miss''),''mm/dd/yyyy hh24:mi:ss'') file_date,''Y'' with_timestamp FROM dual',
'PREVIOUS_BUSINESS_DAY',null,null,'WMST_MONTHLY_METRIC_TOTALS_ID');

INSERT INTO file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file,derive_timestamp_stmt,file_day_received,current_table_name,current_table_primary_key,full_load_table_primary_key) 
 VALUES('WMSTMETRICDETAILS_','INEO_WMST_METRIC_DETAILS_HISTORY','INEO',
'region,office,caseworker,filename,record_id,user_id,taskcall,task_namecall_record,task_completion_date,call_record_date,review_completion_date,total_possible_earned,maximum_possible_points,total_percentage_score,e2e_deduction,final_percentage_score',
'region,office,caseworker,filename,TRY_CAST(record_id AS NUMBER),user_id,taskcall,task_namecall_record,TRY_CAST(task_completion_date AS DATE),TRY_CAST(call_record_date AS DATE),
TRY_CAST(review_completion_date AS DATE),TRY_CAST(total_possible_earned AS NUMBER),TRY_CAST(maximum_possible_points AS NUMBER),TRY_CAST(total_percentage_score AS FLOAT),
TRY_CAST(e2e_deduction AS FLOAT),TRY_CAST(final_percentage_score AS FLOAT)',
'WHERE 1=1',
'Y',
'SELECT TO_CHAR(TO_TIMESTAMP(TRIM(SUBSTR(<filename>,LENGTH(<filename>)-13)),''mmddyyyyhh24miss''),''mm/dd/yyyy hh24:mi:ss'') file_date,''Y'' with_timestamp FROM dual',
'PREVIOUS_BUSINESS_DAY',null,null,'WMSTMETRICDETAILS_ID');