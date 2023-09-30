Create table d_AM_CURRENT  (
AM_ID	 		NUMBER	not null
,ALERT_NAME	 	VARCHAR2(100)	not null
,REPORT_NUMBER	 	VARCHAR2(30)	
,EXPECTED_RPT_RUN_DT	DATE	not null
,EXPECTED_RPT_RUN_TIME	varchar2(10)	not null
,CREATE_DT	 	DATE	not null
,CREATED_BY	 	VARCHAR2(50)	not null
,ALERT_STATUS	 	VARCHAR2(50)	not null
,ALERT_STATUS_DT	DATE	not null
,ALERT_FREQUENCY	VARCHAR2(50)	not null
,ALERT_OUTCOME	 	VARCHAR2(20)	
,ACTUAL_RUN_DT	 	DATE	
,ACTUAL_RUN_TIME	varchar2(10)	
,MSTR_ERROR_MSG	 	VARCHAR2(100)	
,NOT_IN_SUBSCRIPTION_FLAG 	VARCHAR2(1)	
,SEND_TO_FEATURE_FLAG	 	VARCHAR2(1)	
,CANCEL_DT	 	DATE	
,CANCEL_BY	 	VARCHAR2(50)	
,CANCEL_REASON	 	VARCHAR2(50)	
,CANCEL_METHOD	 	VARCHAR2(50)	
,COMPLETE_DT	 	DATE	
,INSTANCE_STATUS	VARCHAR2(10)	
);

create public synonym d_am_current for maxdat.d_am_current;

create sequence seq_am_id start with 1 increment by 1;

alter table d_am_current add constraint dam_unique unique(alert_name, expected_rpt_run_dt, expected_rpt_run_time);

alter table d_am_current add constraint dam_chk_subscription_flg check (not_in_subscription_flag in ('Y','N'));

alter table d_am_current add constraint dam_chk_feature_flg check (send_to_feature_flag in ('Y','N'));

alter table d_am_current add constraint dam_chk_cancel_method check (cancel_method in ('Exception','Normal'));

alter table d_am_current add constraint dam_chk_inst_status check (instance_status in ('Active','Complete'));

GRANT SELECT ON d_am_current TO MAXDAT_READ_ONLY;

alter table d_am_current add constraint d_am_current_PK primary key (am_ID) using index tablespace MAXDAT_INDX;

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
, dref.report_created_by
, dref.rep_freq_type
, dref.rep_freq_day1
, dref.rep_freq_day2
, dref.rep_freq_day3
, dref.rep_freq_day4
, dref.rep_freq_day5
, dref.rep_freq_day6
, dref.rep_freq_day7
, dref.rep_freq_mltptimesaday
, dref.rep_freq_hour1
, dref.rep_freq_hour2
, dref.rep_freq_hour3
, dref.rep_freq_hour4
, dref.rep_freq_hour5
, dref.rep_freq_hour6
, dref.rep_freq_hour7
, dref.rep_freq_hour8
, dref.rep_freq_hour9
, dref.rep_freq_hour10
, dref.rep_freq_hour11
, dref.rep_freq_hour12
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

grant select on d_am_current_SV to MAXDAT_READ_ONLY;

CREATE INDEX AM_ID_NAME ON D_AM_CURRENT (ALERT_NAME) tablespace MAXDAT_INDX;

