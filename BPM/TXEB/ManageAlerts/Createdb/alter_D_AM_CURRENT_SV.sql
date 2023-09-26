create or replace view d_am_current_SV as
select 
am.*
, dref.report_prefix
, dref.report_number report_num
, dref.report_name
, dref.report_Description
, dref.report_location
, dref.kpr
, dref.business_process
, dref.report_type
, dref.report_display
, dref.analyst_name
, dref.backup_ba_name
, dref.alter_type
, dref.report_frequency_desc
, dref.report_delivery_desc
, dref.report_created_by
, dref.backup_ba_name
, dref.alert_type
, dref.report_frequency_desc
, dref.report_delivery_desc 
, dref.delivery_rule 
, dref.rep_login
, dref.report_subscribers
, dref.effective_from_date
, dref.effective_thru_date
, nvl(acout.alert_complete_color, astatus.alert_status_color) alert_color
from d_am_current am, d_report_definition dref
, (select value alert_status_value, out_var alert_status_color from corp_etl_list_lkup ls
where ls.name = 'ALERT_STATUS') astatus
, (select value alert_complete_value, out_var alert_complete_color from corp_etl_list_lkup ls
where ls.name = 'ALERT_COMPLETE_OUTCOME') acout
where am.alert_name = dref.report_name
and astatus.alert_status_value(+) = am.alert_status
and acout.alert_complete_value(+) = am.alert_outcome
order by am.am_id desc
with read only;
