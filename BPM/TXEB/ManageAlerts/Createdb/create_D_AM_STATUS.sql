Create table d_AM_STATUS  (
AMS_ID	 		NUMBER	not null
,AM_ID			NUMBER  not null
,AMS_REVIEW_STATUS	VARCHAR2(50) not null
,AMS_REVIEW_STATUS_DT   DATE NOT NULL
,AMS_ANALYST_NAME	VARCHAR2(100)
,AMS_COMMENTS		VARCHAR2(1500)
,AMS_JIRA_NUMBER	NUMBER
,INSTANCE_STATUS	VARCHAR2(10)
,CANCEL_DT	 	DATE	
,CANCEL_BY	 	VARCHAR2(50)	
,CANCEL_REASON	 	VARCHAR2(50)	
,CANCEL_METHOD	 	VARCHAR2(50)	
,COMPLETE_DT	 	DATE	
,CREATE_DT	 	DATE	not null
,CREATED_BY	 	VARCHAR2(50)	not null
);

create public synonym d_am_status for maxdat.d_am_status;

create sequence seq_ams_id start with 1 increment by 1;

alter table d_am_status add constraint dams_unique unique(am_id);

alter table d_am_status add constraint dams_chk_cancel_method check (cancel_method in ('Exception','Normal'));

alter table d_am_status add constraint dams_chk_inst_status check (instance_status in ('Active','Complete'));

GRANT SELECT ON d_am_status TO MAXDAT_READ_ONLY;

alter table d_am_status add constraint d_am_status_PK primary key (ams_ID) using index tablespace MAXDAT_INDX;

Create table d_AM_STATUS_HIST  (
AMSHIST_ID		NUMBER not null
,AMS_ID	 		NUMBER	not null
,AM_ID			NUMBER  not null
,DML_TYPE		VARCHAR2(3)
,AMS_REVIEW_STATUS	VARCHAR2(50) not null
,AMS_REVIEW_STATUS_DT   DATE NOT NULL
,AMS_ANALYST_NAME	VARCHAR2(100)
,AMS_COMMENTS		VARCHAR2(1500)
,AMS_JIRA_NUMBER	NUMBER
,INSTANCE_STATUS	VARCHAR2(10)
,CANCEL_DT	 	DATE	
,CANCEL_BY	 	VARCHAR2(50)	
,CANCEL_REASON	 	VARCHAR2(50)	
,CANCEL_METHOD	 	VARCHAR2(50)	
,COMPLETE_DT	 	DATE	
,CREATE_DT	 	DATE	not null
,CREATED_BY	 	VARCHAR2(50)	not null
);

create public synonym d_am_status_hist for maxdat.d_am_status_hist;

create sequence seq_amshist_id start with 1 increment by 1;

GRANT SELECT ON d_am_status_hist TO MAXDAT_READ_ONLY;

alter table d_am_status_hist add constraint d_am_status_hist_PK primary key (amshist_ID) using index tablespace MAXDAT_INDX;

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
, dref.analyst_name
, dref.backup_ba_name
, dref.alter_type
, dref.report_frequency_desc
, dref.report_delivery_desc
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

grant select on d_am_status_SV to MAXDAT_READ_ONLY;

CREATE INDEX AM_STATUS_HIST_AMS_ID ON D_AM_STATUS_HIST (AMS_ID) tablespace MAXDAT_INDX;
