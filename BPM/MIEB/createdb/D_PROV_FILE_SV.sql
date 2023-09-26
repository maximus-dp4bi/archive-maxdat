create or replace view D_PROV_FILE_SV AS
select  
job_id
, filename
, plan_service_type || ' - ' || trim(plan_name) || ' - ' || to_char(record_date,'mm/dd/yyyy') || ' - ' || substr(filename, instr(filename,'/',-1)+1) file_label 
, record_date
, plan_id_ext
, plan_id
, plan_service_type
, total_submitted
, total_loaded
, total_not_loaded
, total_duplicate
, total_errors
 from (
select /*+ parallel(20) */ r.job_id
, r.filename FILENAME
, trunc(r.start_ts) record_date
, i.MHP_MEDICAID_PROVIDER_NUMBER
, P.plan_id
, P.PLAN_ID_EXT
, p.plan_name
, P.plan_service_type
, i.total_submitted
, i.total_loaded
, i.total_not_loaded
, i.total_duplicate
, nvl(nr.error_count,0) total_errors
, rank() OVER(PARTITION BY i.MHP_MEDICAID_PROVIDER_NUMBER ORDER BY trunc(r.start_ts) DESC) file_latest_rank
from JOB_RUN_DATA jd 
inner join etl_report r on r.job_id = jd.job_run_data_id
--left join etl_report_control rc on (rc.job_id = r.job_id and rc.filename = r.filename)
join (select /*+ parallel(20) */ i4.job_id, i4.MHP_MEDICAID_PROVIDER_NUMBER 
             , count(distinct i4.row_num) total_submitted
             , sum(case when NVL(i4.error_count,0) = 0 then 1 else 0 end) total_loaded
             , sum(case when NVL(i4.error_count,0) = 0 then 0 else 1 end) total_not_loaded
             , sum(case when i4.ERROR_TEXT like '[%Duplicate%]' then 1 else 0 end) total_duplicate
             from etl_init_4275 i4 
             where i4.job_id >= 63461 group by i4.job_id, i4.MHP_MEDICAID_PROVIDER_NUMBER
      union
      select /*+ parallel(20) */ d4.job_id, d4.MHP_MEDICAID_PROVIDER_NUMBER 
             , count(distinct d4.row_num) total_submitted
             , sum(case when NVL(d4.error_count,0) = 0 then 1 else 0 end) total_loaded
             , sum(case when NVL(d4.error_count,0) = 0 then 0 else 1 end) total_not_loaded
             , sum(case when d4.ERROR_TEXT like '[%Duplicate%]' then 1 else 0 end) total_duplicate
             from eb.etl_init_5937 d4 
             group by d4.job_id, d4.MHP_MEDICAID_PROVIDER_NUMBER
                   ) i on (i.job_id = r.job_id )
JOIN emrs_d_plan_sv P ON P.plan_service_type in ('MAINSTREAM','ICO','DENTAL') AND P.PLAN_ID_EXT = i.MHP_MEDICAID_PROVIDER_NUMBER
left join (select /*+ parallel(20) */ n4.job_id, count(1) error_count from etl_l_network_response n4 where n4.message_level = 'ERROR' group by n4.job_id
           ) nr on nr.job_id = jd.job_run_data_id 
where 1=1
and JD.JOB_NAME like '%Provider Load Job%'
--and jd.job_run_data_id = 80181
--and i.row_num = 38052
--and trunc(JD.CREATE_TS) >= add_months(TRUNC(sysdate,'mm'),-2)
)
where 1=1
and file_latest_rank <= 10
;

GRANT SELECT ON MAXDAT_SUPPORT.D_PROV_FILE_SV TO MAXDAT_REPORTS ;

