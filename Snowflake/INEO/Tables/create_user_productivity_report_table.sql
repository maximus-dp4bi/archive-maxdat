CREATE OR REPLACE SEQUENCE seq_user_productivity_report_id;

CREATE OR REPLACE TABLE INEO_CC_USER_PRODUCTIVITY_REPORT_HISTORY(
user_productivity_report_id NUMBER NOT NULL DEFAULT seq_user_productivity_report_id.nextval,
as_of_date DATE,
department VARCHAR,
last_name VARCHAR,
name VARCHAR,
i3_username VARCHAR,
offered FLOAT,
answered FLOAT,
abandoned FLOAT,
transferred FLOAT,
time_talk_acd FLOAT,
filename VARCHAR,
percent_answered FLOAT,
percent_abandoned FLOAT,
flow_outs FLOAT,
percent_flow_outs FLOAT,
percent_transferred FLOAT,
talk_time_hold_time FLOAT,
talk_time_avg FLOAT,
hold_time FLOAT,
hold_time_avg FLOAT,
acw_time FLOAT,
acw_avg FLOAT,
talkholdacw_duration_time FLOAT,
talkholdacw_avg FLOAT,
sf_create_ts TIMESTAMP_NTZ(9) DEFAULT current_timestamp(),
sf_update_ts TIMESTAMP_NTZ(9) DEFAULT current_timestamp());

 
ALTER TABLE INEO_CC_USER_PRODUCTIVITY_REPORT_HISTORY ADD PRIMARY KEY(user_productivity_report_id);

DELETE FROM file_load_lkup
WHERE filename_prefix = 'USER_PRODUCTIVITY_REPORT_';


INSERT INTO file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file,derive_timestamp_stmt,file_day_received,current_table_name,current_table_primary_key,full_load_table_primary_key) 
 VALUES('USER_PRODUCTIVITY_REPORT_','INEO_CC_USER_PRODUCTIVITY_REPORT_HISTORY','INEO',
'as_of_date,department,name,last_name,i3_username,offered,answered,abandoned,transferred,time_talk_acd,filename,percent_answered,percent_abandoned,flow_outs,percent_flow_outs,percent_transferred,talk_time_hold_time,talk_time_avg,hold_time,hold_time_avg,acw_time,acw_avg,talkholdacw_duration_time,talkholdacw_avg',
'TO_DATE(as_of_dt,''mm/dd/yyyy''),department,name,last_name,i3_username,TRY_CAST(offered AS FLOAT),TRY_CAST(answered AS FLOAT),TRY_CAST(abandoned AS FLOAT),TRY_CAST(transferred AS FLOAT),
TRY_CAST(time_talk_acd AS FLOAT),filename,TRY_CAST(_answered AS FLOAT),TRY_CAST(_abandoned AS FLOAT),TRY_CAST(flow_outs AS FLOAT),TRY_CAST(_flow_outs AS FLOAT),TRY_CAST(_transferred AS FLOAT),
TRY_CAST(talk_time_hold_time AS FLOAT),TRY_CAST(talk_time_avg AS FLOAT),TRY_CAST(hold_time AS FLOAT),TRY_CAST(hold_time_avg AS FLOAT),TRY_CAST(acw_time AS FLOAT),
TRY_CAST(acw_avg AS FLOAT),TRY_CAST(talkholdacw_duration_time AS FLOAT),TRY_CAST(talkholdacw_avg AS FLOAT)',
'WHERE 1=1',
'Y',
'SELECT TO_CHAR(TO_TIMESTAMP(TRIM(SUBSTR(<filename>,LENGTH(<filename>)-7)),''mmddyyyy''),''mm/dd/yyyy'') file_date,''N'' with_timestamp FROM dual',
'PREVIOUS_BUSINESS_DAY',
null,null,'USER_PRODUCTIVITY_REPORT_ID');
 
 