create or replace view f_prov_load_sv as
select /*+ parallel(10) */ job_id
, filename
, record_date
, plan_id
, plan_id_ext
, plan_service_type
, total_submitted
, TOTAL_LOADED
, total_not_loaded
, total_duplicate
, nvl(total_errors,0) total_errors
, total_not_loaded - total_duplicate total_unique_err_records
, unique_errors
from (
select job_id
, filename
, record_date
, plan_id
, plan_id_ext
, plan_service_type
, total_submitted
, TOTAL_LOADED
, total_not_loaded
, total_duplicate
, nvl(total_errors,0) total_errors
, total_not_loaded - total_duplicate total_unique_err_records
, unique_errors
, rank() OVER(PARTITION BY plan_id_ext ORDER BY start_ts DESC) file_latest_rank
from (
select r.job_id
, r.filename FILENAME
, trunc(r.start_ts) record_date
, P.plan_id
, P.PLAN_ID_EXT
, P.plan_service_type
, i.total_submitted
, i.total_loaded
, i.total_not_loaded
, i.total_duplicate
, (nr.error_count) total_errors
, nr.unique_errors
, r.start_ts
--, rank() OVER(PARTITION BY i.MHP_MEDICAID_PROVIDER_NUMBER ORDER BY r.start_ts DESC) file_latest_rank
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
LEFT JOIN emrs_d_plan_sv P ON P.plan_service_type in ('MAINSTREAM','ICO','DENTAL') AND P.PLAN_ID_EXT = i.MHP_MEDICAID_PROVIDER_NUMBER
left join (select job_id, unique_errors, error_count from (
                  select job_id, listagg(n1.error_message,',' on overflow truncate with count) within group (order by n1.error_message) unique_errors, sum(unique_error_count) error_count from
                  (select /*+ parallel(20) */ job_id, error_message, count(1) unique_error_count from etl_l_network_response nr where message_level = 'ERROR' group by job_id, error_message) n1
                  group by job_id
                  )
           ) nr on nr.job_id = jd.job_run_data_id
where 1=1
and JD.JOB_NAME like '%Provider Load Job%'
--and jd.job_run_data_id = 75121
--and i.row_num = 38052
--and trunc(JD.CREATE_TS) >= add_months(TRUNC(sysdate,'mm'),-1)
/*group by r.job_id
, r.filename
, trunc(r.start_ts)
, P.plan_id
, P.PLAN_ID_EXT
, P.plan_service_type
, i.MHP_MEDICAID_PROVIDER_NUMBER
, nr.error_count
, nr.unique_errors
*/
union all
select r.job_id
, r.filename FILENAME
, trunc(r.start_ts) record_date
, P.plan_id
, P.PLAN_ID_EXT
, P.plan_service_type
, i.total_submitted
, i.total_loaded
, i.total_not_loaded
, i.total_duplicate
, (nr.error_count) total_errors
, nr.unique_errors
, r.start_ts
--, rank() OVER(PARTITION BY i.MHP_MEDICAID_PROVIDER_NUMBER ORDER BY r.start_ts DESC) file_latest_rank
from JOB_RUN_DATA@EB_TO_ARC_PUB_DB_LINK jd
inner join etl_report@EB_TO_ARC_PUB_DB_LINK r on r.job_id = jd.job_run_data_id
--left join etl_report_control rc on (rc.job_id = r.job_id and rc.filename = r.filename)
join (select /*+ parallel(20) */ i4.job_id, i4.MHP_MEDICAID_PROVIDER_NUMBER
             , count(distinct i4.row_num) total_submitted
             , sum(case when NVL(i4.error_count,0) = 0 then 1 else 0 end) total_loaded
             , sum(case when NVL(i4.error_count,0) = 0 then 0 else 1 end) total_not_loaded
             , sum(case when i4.ERROR_TEXT like '[%Duplicate%]' then 1 else 0 end) total_duplicate
             from etl_init_4275@EB_TO_ARC_PUB_DB_LINK i4
             where i4.MHP_MEDICAID_PROVIDER_NUMBER in
                  (select plan_id_ext from emrs_d_plan_sv p where plan_service_type in ('MAINSTREAM','ICO')
                  and not exists (select 'x'  from etl_init_4275 e4 where e4.MHP_MEDICAID_PROVIDER_NUMBER = p.PLAN_ID_EXT)
                  )
             group by i4.job_id, i4.MHP_MEDICAID_PROVIDER_NUMBER
      union
      select /*+ parallel(10) */ d4.job_id, d4.MHP_MEDICAID_PROVIDER_NUMBER
             , count(distinct d4.row_num) total_submitted
             , sum(case when NVL(d4.error_count,0) = 0 then 1 else 0 end) total_loaded
             , sum(case when NVL(d4.error_count,0) = 0 then 0 else 1 end) total_not_loaded
             , sum(case when d4.ERROR_TEXT like '[%Duplicate%]' then 1 else 0 end) total_duplicate
             from eb.etl_init_5937@EB_TO_ARC_PUB_DB_LINK d4
             group by d4.job_id, d4.MHP_MEDICAID_PROVIDER_NUMBER
             ) i on (i.job_id = r.job_id )
LEFT JOIN emrs_d_plan_sv P ON P.plan_service_type in ('MAINSTREAM','ICO','DENTAL') AND P.PLAN_ID_EXT = i.MHP_MEDICAID_PROVIDER_NUMBER
left join (select job_id, unique_errors, error_count from (
                  select job_id, listagg(n1.error_message,',' on overflow truncate with count) within group (order by n1.error_message) unique_errors, sum(unique_error_count) error_count from
                  (select /*+ parallel(10) */ job_id, error_message, count(1) unique_error_count from etl_l_network_response@EB_TO_ARC_PUB_DB_LINK nr where message_level = 'ERROR' group by job_id, error_message) n1
                  group by job_id
                  )
           ) nr on nr.job_id = jd.job_run_data_id
where 1=1
and JD.JOB_NAME like '%Provider Load Job%'
)
)
where file_latest_rank = 1
and plan_id is not null
;

GRANT SELECT ON MAXDAT_SUPPORT.f_PROV_LOAD_SV TO MAXDAT_REPORTS ;
