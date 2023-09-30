CREATE OR REPLACE VIEW F_PA_INPROCESS_SV
AS
select /*+ parallel(10) */ 
sum(under60) APPS_UNDER60
, sum(over60) APPS_OVER60
, count(application_id) APPS_TOTAL 
from (select ah.application_id
, CASE WHEN trunc((to_number(to_char(he.app_start_date,'YYYYMMDD'))- to_number(to_char(c.clnt_dob,'YYYYMMDD')))/10000) > 60 THEN 1 else 0 end over60
, CASE WHEN trunc((to_number(to_char(he.app_start_date,'YYYYMMDD'))- to_number(to_char(c.clnt_dob,'YYYYMMDD')))/10000) > 60 THEN 0 else 1 end under60
FROM app_header ah
JOIN app_individual i ON (ah.application_id = i.application_id) 
JOIN client c ON (i.client_id = c.clnt_client_id)
LEFT JOIN app_header_ext he ON ah.application_id = he.application_id
left join maxdat_support.d_app_status apst on apst.app_status_code = ah.status_cd 
where apst.APP_STATUS not in ('Completed', 'Closed', 'Pending', 'Timeout', 'Disregarded', 'Enrolled')
and ah.application_id >= 343555
and ah.create_ts >= ADD_MONTHS(TRUNC(sysdate, 'mm'), -13)
);
   
GRANT SELECT ON F_PA_INPROCESS_SV TO MAXDAT_REPORTS;
GRANT SELECT ON F_PA_INPROCESS_SV TO MAXDAT_SUPPORT_READ_ONLY;
            
