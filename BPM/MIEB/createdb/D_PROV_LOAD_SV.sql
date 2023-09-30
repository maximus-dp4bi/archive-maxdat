create or replace view D_PROV_LOAD_SV AS
select r.job_id
, r.filename FILENAME
, trunc(r.start_ts) record_date
, i.row_num
, i.MHP_MEDICAID_PROVIDER_NUMBER
, i.provider_site_number
, i.plans_provider_number
, nr.field_name
, nr.message_level
, nr.error_message
, i.error_count
, P.plan_id
, P.PLAN_ID_EXT
, P.plan_service_type
, case when i.ERROR_TEXT like '[%Duplicate%]' then 1 else 0 end record_duplicate
, case when NVL(i.error_count,0) = 0 then 1 else 0 end record_loaded
, case when NVL(i.error_count,0) = 0 then 0 else 1 end record_not_loaded
, rank() OVER(PARTITION BY i.MHP_MEDICAID_PROVIDER_NUMBER ORDER BY trunc(r.start_ts) DESC) file_latest_rank
, row_number() over(partition by r.job_id, r.filename, i.row_num order by nr.field_name) file_row_order
from JOB_RUN_DATA jd 
inner join etl_report r on r.job_id = jd.job_run_data_id
--left join etl_report_control rc on (rc.job_id = r.job_id and rc.filename = r.filename)
join etl_init_4275 i on (i.job_id = r.job_id )
LEFT JOIN emrs_d_plan_sv P ON P.plan_service_type in ('MAINSTREAM','ICO','DENTAL') AND P.PLAN_ID_EXT = i.MHP_MEDICAID_PROVIDER_NUMBER
left join etl_l_network_response nr on nr.row_num = i.row_num and nr.job_id = jd.job_run_data_id and nr.message_level = 'ERROR'
where 1=1
and JD.JOB_NAME like '%Provider Load Job%'
--and jd.job_run_data_id = 75121
--and i.row_num = 38052
and trunc(JD.CREATE_TS) >= add_months(TRUNC(sysdate,'mm'),-2)
;

  GRANT SELECT ON MAXDAT_SUPPORT.D_PROV_LOAD_SV TO MAXDAT_REPORTS ;

