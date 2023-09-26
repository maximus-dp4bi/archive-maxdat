create or replace view D_PROV_ERROR_SV AS
select /*+ parallel(20) */ nr.job_id
, COALESCE(i4.MHP_MEDICAID_PROVIDER_NUMBER, d4.MHP_MEDICAID_PROVIDER_NUMBER) MHP_MEDICAID_PROVIDER_NUMBER
, COALESCE(i4.provider_site_number, d4.provider_site_number) provider_site_number
, COALESCE(i4.plans_provider_number, d4.plans_provider_number) plans_provider_number
, nr.field_name
, nr.message_level
, nr.error_message
from etl_l_network_response nr 
left join etl_init_4275 i4 on i4.job_id = nr.job_id and i4.row_num = nr.row_num
left join eb.etl_init_5937 d4 on d4.job_id = nr.job_id and d4.row_num = nr.row_num
where 1=1
and nr.message_level = 'ERROR'
;

  GRANT SELECT ON MAXDAT_SUPPORT.D_PROV_ERROR_SV TO MAXDAT_REPORTS ;

