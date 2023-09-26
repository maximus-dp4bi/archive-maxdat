CREATE OR REPLACE VIEW D_PA_AUTODIAL_RESULT_SV
AS
select v.etl_l_ivr_ib_id
       ,v.unique_identifier
       ,v.campaign_name
       ,v.sub_campaign
       ,v.call_start
       ,v.call_end
       ,v.result call_result
       ,v.job_id
       ,v.row_num
       ,v.phone_nuumber phone_number
from etl_l_ivr_ib v;

GRANT SELECT ON D_PA_AUTODIAL_RESULT_SV TO MAXDAT_REPORTS;