create or replace view d_am_status_SV as
select 
ams.*
, am.alert_name
, am.report_number
, am.expected_rpt_run_dt
, am.expected_rpt_run_time
, am.alert_status
, am.alert_status_dt
, am.alert_frequency
, am.alert_outcome
, am.actual_run_dt
, am.instance_status alert_instance_status
, dref.report_prefix
, dref.report_number report_num
, dref.report_name
, dref.report_Description
, dref.report_location
, dref.kpr
, dref.business_process
, dref.report_type
, dref.report_display
, dref.backup_ba_name
, dref.alert_type
, dref.report_frequency_desc
, dref.report_delivery_desc 
, dref.delivery_rule 
, dref.report_created_by
, dref.rep_login
, dref.report_subscribers
, dref.effective_from_date
, dref.effective_thru_date
, nvl(acout.alert_complete_color, astatus.alert_status_color) alert_color
, areviewstatus.alert_status_color alert_status_color
from d_am_current am, d_report_definition dref, d_am_status ams
, (select value alert_status_value, out_var alert_status_color from corp_etl_list_lkup ls
where ls.name = 'ALERT_STATUS') astatus
, (select value alert_complete_value, out_var alert_complete_color from corp_etl_list_lkup ls
where ls.name = 'ALERT_COMPLETE_OUTCOME') acout
, (select value alert_status_value, out_var alert_status_color from corp_etl_list_lkup ls
where ls.name = 'ALERT_REVIEW_STATUS') areviewstatus
where am.alert_name = dref.report_name
and ams.am_id = am.am_id
and astatus.alert_status_value(+) = am.alert_status
and acout.alert_complete_value(+) = am.alert_outcome
and areviewstatus.alert_status_value(+) = ams.ams_review_status
order by am.am_id desc
with read only;
