use schema ineo;
CREATE OR REPLACE VIEW INEO_D_CALL_DETAILS_BY_DAY_SV
AS
SELECT * FROM ineo.ineo_call_detail_by_day;

CREATE OR REPLACE VIEW INEO_D_CALL_DETAILS_BY_DAY_HISTORY_SV
AS
SELECT * FROM ineo.ineo_call_detail_by_day_history;

CREATE OR REPLACE VIEW INEO_D_QA_RANDOM_CALL_DETAILS_SV
AS
SELECT i.call_date
,call_id
,call_start_ts
,call_end_ts
,call_duration
,wrap_up_cd
,queue_nm queue_name
,user_id
,transfer_count
,type_of_transfer
FROM(SELECT random() rand_num,i.*,ROW_NUMBER() OVER(PARTITION BY user_id, DATE_TRUNC('MONTH',call_date) ORDER BY DATE_TRUNC('DAY',call_date) DESC,rand_num) rn
FROM ineo.ineo_call_detail_by_day i) i
WHERE rn  <= 2 ;