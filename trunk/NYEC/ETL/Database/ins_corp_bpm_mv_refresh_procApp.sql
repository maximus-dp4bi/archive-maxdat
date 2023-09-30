SELECT * FROM corp_bpm_mv_refresh
WHERE process = 'ProcessApp';

--select 
--'insert into corp_bpm_mv_refresh values (''ProcessApp'','''||MV_NAME||''',''F'');' 
--from MV_REFRESH_GROUP where REFRESH_GROUP_NAME = 'NYEC_PROCESS_APP' order by MV_NAME asc;

DELETE FROM corp_bpm_mv_refresh WHERE process = 'ProcessApp';
insert into corp_bpm_mv_refresh values ('ProcessApp','V_D_APPLICATION_ID','F');
insert into corp_bpm_mv_refresh values ('ProcessApp','V_D_APPLICATION_TYPE','F');
insert into corp_bpm_mv_refresh values ('ProcessApp','V_D_APP_COMPLETE_RESULT','F');
insert into corp_bpm_mv_refresh values ('ProcessApp','V_D_APP_STATUS','F');
insert into corp_bpm_mv_refresh values ('ProcessApp','V_D_APP_STATUS_GROUP','F');
insert into corp_bpm_mv_refresh values ('ProcessApp','V_D_AUTO_REPROCESS_FLAG','F');
insert into corp_bpm_mv_refresh values ('ProcessApp','V_D_CANCEL_APP_FLAG','F');
insert into corp_bpm_mv_refresh values ('ProcessApp','V_D_CANCEL_APP_PERFORMED_BY','F');
insert into corp_bpm_mv_refresh values ('ProcessApp','V_D_CANCEL_DATE','F');
insert into corp_bpm_mv_refresh values ('ProcessApp','V_D_CHANNEL','F');
insert into corp_bpm_mv_refresh values ('ProcessApp','V_D_CLOCKDOWN_INDICATOR','F');
insert into corp_bpm_mv_refresh values ('ProcessApp','V_D_CLOSE_APP_FLAG','F');
insert into corp_bpm_mv_refresh values ('ProcessApp','V_D_COMPLETE_APP_PERFORMED_BY','F');
insert into corp_bpm_mv_refresh values ('ProcessApp','V_D_COUNTY','F');
insert into corp_bpm_mv_refresh values ('ProcessApp','V_D_CURRENT_TASK_ID','F');
insert into corp_bpm_mv_refresh values ('ProcessApp','V_D_DATA_ENTRY_TASK_ID','F');
insert into corp_bpm_mv_refresh values ('ProcessApp','V_D_ELIGIBILITY_ACTION','F');
insert into corp_bpm_mv_refresh values ('ProcessApp','V_D_HEART_APP_STATUS','F');
insert into corp_bpm_mv_refresh values ('ProcessApp','V_D_HEART_SYNCH_FLAG','F');
insert into corp_bpm_mv_refresh values ('ProcessApp','V_D_KPR_APP_CYCLE_BUS_DAYS','F');
insert into corp_bpm_mv_refresh values ('ProcessApp','V_D_KPR_APP_CYCLE_END_DATE','F');
insert into corp_bpm_mv_refresh values ('ProcessApp','V_D_KPR_APP_CYCLE_START_DATE','F');
insert into corp_bpm_mv_refresh values ('ProcessApp','V_D_LAST_MAIL_DATE','F');
insert into corp_bpm_mv_refresh values ('ProcessApp','V_D_MISSING_INFORMATION_FLAG','F');
insert into corp_bpm_mv_refresh values ('ProcessApp','V_D_MI_RECEIVED_TASK_COUNT','F');
insert into corp_bpm_mv_refresh values ('ProcessApp','V_D_NEW_MI_FLAG','F');
insert into corp_bpm_mv_refresh values ('ProcessApp','V_D_NOTIFY_CLIENT_PA_DATE','F');
insert into corp_bpm_mv_refresh values ('ProcessApp','V_D_NOTIFY_CLIENT_PA_FLAG','F');
insert into corp_bpm_mv_refresh values ('ProcessApp','V_D_NOTIFY_CLIENT_PA_PB','F');
insert into corp_bpm_mv_refresh values ('ProcessApp','V_D_NOTIFY_CLIENT_PA_START','F');
insert into corp_bpm_mv_refresh values ('ProcessApp','V_D_OUTCOME_NOTIF_REQ_FLAG','F');
insert into corp_bpm_mv_refresh values ('ProcessApp','V_D_PEND_NOTIFICATION_REQ_FLAG','F');
insert into corp_bpm_mv_refresh values ('ProcessApp','V_D_PERFORM_QC_DATE','F');
insert into corp_bpm_mv_refresh values ('ProcessApp','V_D_PERFORM_QC_FLAG','F');
insert into corp_bpm_mv_refresh values ('ProcessApp','V_D_PERFORM_QC_PERFORMED_BY','F');
insert into corp_bpm_mv_refresh values ('ProcessApp','V_D_PERFORM_QC_START_DATE','F');
insert into corp_bpm_mv_refresh values ('ProcessApp','V_D_PERFORM_RESEARCH_DATE','F');
insert into corp_bpm_mv_refresh values ('ProcessApp','V_D_PERFORM_RESEARCH_FLAG','F');
insert into corp_bpm_mv_refresh values ('ProcessApp','V_D_PERFORM_RESEARCH_PB','F');
insert into corp_bpm_mv_refresh values ('ProcessApp','V_D_PERFORM_RESEARCH_START','F');
insert into corp_bpm_mv_refresh values ('ProcessApp','V_D_PROCESS_APP_INFO_DATE','F');
insert into corp_bpm_mv_refresh values ('ProcessApp','V_D_PROCESS_APP_INFO_FLAG','F');
insert into corp_bpm_mv_refresh values ('ProcessApp','V_D_PROCESS_APP_INFO_PB','F');
insert into corp_bpm_mv_refresh values ('ProcessApp','V_D_PROCESS_APP_INFO_START','F');
insert into corp_bpm_mv_refresh values ('ProcessApp','V_D_QC_OUTCOME_FLAG','F');
insert into corp_bpm_mv_refresh values ('ProcessApp','V_D_QC_REQUIRED_FLAG','F');
insert into corp_bpm_mv_refresh values ('ProcessApp','V_D_QC_TASK_ID','F');
insert into corp_bpm_mv_refresh values ('ProcessApp','V_D_RECEIPT_DATE','F');
insert into corp_bpm_mv_refresh values ('ProcessApp','V_D_RECEIVE_APP_FLAG','F');
insert into corp_bpm_mv_refresh values ('ProcessApp','V_D_RECEIVE_PROCESS_MI_FLAG','F');
insert into corp_bpm_mv_refresh values ('ProcessApp','V_D_REFER_TO_LDSS_FLAG','F');
insert into corp_bpm_mv_refresh values ('ProcessApp','V_D_RESEARCH_FLAG','F');
insert into corp_bpm_mv_refresh values ('ProcessApp','V_D_RESEARCH_REASON','F');
insert into corp_bpm_mv_refresh values ('ProcessApp','V_D_RESEARCH_TASK_ID','F');
insert into corp_bpm_mv_refresh values ('ProcessApp','V_D_REVIEW_ENTER_DATA_DATE','F');
insert into corp_bpm_mv_refresh values ('ProcessApp','V_D_REVIEW_ENTER_DATA_FLAG','F');
insert into corp_bpm_mv_refresh values ('ProcessApp','V_D_REVIEW_ENTER_DATA_PB','F');
insert into corp_bpm_mv_refresh values ('ProcessApp','V_D_REVIEW_ENTER_START_DATE','F');
insert into corp_bpm_mv_refresh values ('ProcessApp','V_D_SLA_JEOPARDY_DATE','F');
insert into corp_bpm_mv_refresh values ('ProcessApp','V_D_STATE_REVIEW_TASK_COUNT','F');
insert into corp_bpm_mv_refresh values ('ProcessApp','V_D_STATE_REVIEW_TASK_ID','F');

SELECT * FROM corp_bpm_mv_refresh
WHERE process = 'ProcessApp';
COMMIT;
