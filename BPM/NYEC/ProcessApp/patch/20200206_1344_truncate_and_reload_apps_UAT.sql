execute MAXDAT_ADMIN.SHUTDOWN_JOBS;

delete from PROCESS_APP_STG;
commit;

delete from D_NYEC_PA_CURRENT;
commit;

delete from D_NYEC_PA_APP_STATUS;
commit;

delete from D_NYEC_PA_CIN;
commit;

delete from D_NYEC_PA_COUNTY;
commit;
delete from D_NYEC_PA_FPBP_SUBTYPE;
commit;
delete from D_NYEC_PA_HEART_CASE_STATUS;
commit;
delete from D_NYEC_PA_HEART_INC_APP_IND;
commit;
delete from D_NYEC_PA_HEART_SYNCH;
commit;
delete from D_NYEC_PA_MODE_CODE;
commit;
delete from D_NYEC_PA_OUTCOM_LTR_STATUS;
commit;
delete from D_NYEC_PA_OUTCOME_NOTF_FLAG;
commit;
delete from D_NYEC_PA_REACTIVATION_IND;
commit;
delete from D_NYEC_PA_REACTIVATE_REASON;
commit;
delete from D_NYEC_PA_REACTIVATED_BY;
commit;
delete from D_NYEC_PA_REACTIVATION_NUM;
commit;
delete from D_NYEC_PA_WORKFLOW_REAC_IND;
commit;
delete from D_NYEC_PA_QC_INDICATOR;
commit;
delete from D_NYEC_PA_MA_REASON;
commit;
delete from D_NYEC_PA_REV_CLEAR_REASON;
commit;
delete from F_NYEC_PA_BY_DATE;
commit;
delete from BPM_UPDATE_EVENT_QUEUE where bsl_id=2;
commit;

update corp_etl_control set value = 808284
where name = 'AP_LAST_APPLICATION_ID';
commit;

delete from BPM_LOGGING where BSL_ID = 2;
commit;

