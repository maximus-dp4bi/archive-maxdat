Create or replace view D_SURVEY_SV as
SELECT s.survey_id
, s.client_id CLIENT_NUMBER
, s.case_id CASE_NUMBER
, s.survey_template_id
, t.title SURVEY_TITLE
, s.status_cd
, case when s.status_cd in ('COMPLETED') then 1 else 0 end survey_taken
, case when s.status_cd in ('REFUSED','QUIT') then 1 else 0 end survey_refused
, case when s.status_cd in ('COMPLETED') then 'Take HMP Survey in HRAU' else null end survey_taken_label
, case when s.status_cd in ('REFUSED','QUIT') then 'Refuse HMP Survey in HRAU' else null end survey_refused_label
, s.refuse_reason_cd
, s.received_via_cd
, s.received_date
, trunc(status_date) ca_date
, stf.first_name || ' ' || stf.last_name staff_name
, s.created_by
, s.create_ts
FROM survey s 
 JOIN enum_survey_status ss ON ss.value = s.status_cd 
 JOIN survey_template t ON t.survey_template_id = s.survey_template_id
 left join staff stf on to_char(stf.staff_id) = s.updated_by
WHERE 1=1
AND 1 = (case when (t.title like 'HRAU%Sur%' or t.title like 'HMP%Sur%') and ss.value = 'INITIATED' then 0 else 1 end)
AND 1 = (case when (t.title like 'HRAU%Sur%' or t.title like 'HMP%Sur%') then 1 else 0 end)
AND s.created_by != '-999'
;

GRANT SELECT ON MAXDAT_SUPPORT.D_SURVEY_SV TO MAXDAT_REPORTS;  
