/*
select 'drop public synonym "' || SYNONYM_NAME || '";'
from ALL_SYNONYMS  
where 
  TABLE_OWNER like 'MAXDAT%'
  and OWNER = 'PUBLIC'
order by 
  OWNER asc,
  SYNONYM_NAME asc;
*/
drop public synonym "APP_MIS_STG";
drop public synonym "BIA_BACKUP";
drop public synonym "BPM_ACTIVITY_ATTRIBUTE";
drop public synonym "BPM_ACTIVITY_EVENTS";
drop public synonym "BPM_ACTIVITY_EVENT_TYPE_LKUP";
drop public synonym "BPM_ACTIVITY_LKUP";
drop public synonym "BPM_ACTIVITY_TYPE_LKUP";
drop public synonym "BPM_ATTRIBUTE";
drop public synonym "BPM_ATTRIBUTE_LKUP";
drop public synonym "BPM_ATTRIBUTE_STAGING_TABLE";
drop public synonym "BPM_CIN_SNAPSHOT";
drop public synonym "BPM_CIN_SNAPSHOT_BKUP";
drop public synonym "BPM_COMMON";
drop public synonym "BPM_DATATYPE_LKUP";
drop public synonym "BPM_DATA_MODEL";
drop public synonym "BPM_D_DATES";
drop public synonym "BPM_D_HOURS";
drop public synonym "BPM_D_OPS_GROUP_TASK";
drop public synonym "BPM_EVENT_MASTER";
drop public synonym "BPM_IDENTIFIER_TYPE_LKUP";
drop public synonym "BPM_INSTANCE_ATTRIBUTE_RETIRE";
drop public synonym "BPM_INSTANCE_RETIRE";
drop public synonym "BPM_KOFAX_DOCUMENTS";
drop public synonym "BPM_KOFAX_RELEASE_EVENTS";
drop public synonym "BPM_KOFAX_REL_EVTS_STG";
drop public synonym "BPM_KOFAX_SCAN_EVENTS";
drop public synonym "BPM_LAST_ETL_RUN_SV";
drop public synonym "BPM_LOGGING";
drop public synonym "BPM_PROCESS_FLOW";
drop public synonym "BPM_PROCESS_LKUP";
drop public synonym "BPM_PROGRAM_LKUP";
drop public synonym "BPM_PROJECT_LKUP";
drop public synonym "BPM_REGION_LKUP";
drop public synonym "BPM_SCHEDULER_JOBS";
drop public synonym "BPM_SEMANTIC";
drop public synonym "BPM_SEMANTIC_PROJECT";
drop public synonym "BPM_SOURCE_LKUP";
drop public synonym "BPM_SOURCE_TYPE_LKUP";
drop public synonym "BPM_UPDATE_EVENT_BACKUP";
drop public synonym "BPM_UPDATE_EVENT_QUEUE";
drop public synonym "BPM_UPDATE_EVENT_QUEUE_ARCHIVE";
drop public synonym "BPM_UPDATE_EVENT_RETIRE";
drop public synonym "BPM_UPDATE_TYPE_LKUP";
drop public synonym "BUS_DAYS_BETWEEN";
drop public synonym "CC_EVENT_STG";
drop public synonym "CELL_HISTORY_SEQ";
drop public synonym "CORP_BPM_MV_REFRESH";
drop public synonym "CORP_ETL_COMPLAINTS_INCIDENTS";
drop public synonym "CORP_ETL_COMPLAINTS_PKG";
drop public synonym "CORP_ETL_COMPL_INCIDENTS_OLTP";
drop public synonym "CORP_ETL_COMPL_INCIDN_WIP_BPM";
drop public synonym "CORP_ETL_CONTROL";
drop public synonym "CORP_ETL_ERROR_LOG";
drop public synonym "CORP_ETL_JOB_STATISTICS";
drop public synonym "CORP_ETL_LIST_LKUP";
drop public synonym "CORP_ETL_LIST_LKUP_HIST";
drop public synonym "CORP_ETL_MANAGE_WORK";
drop public synonym "CORP_ETL_MANAGE_WORK_PKG";
drop public synonym "CORP_ETL_MANAGE_WORK_TMP";
drop public synonym "CORP_ETL_MW_V2";
drop public synonym "CORP_ETL_MW_V2_PKG";
drop public synonym "CORP_ETL_MW_V2_WIP";
drop public synonym "CORP_ETL_STAGE_PKG";
drop public synonym "D_BPM";
drop public synonym "D_BPM_DATA_MODEL_SV";
drop public synonym "D_BPM_SOURCE_LKUP_SV";
drop public synonym "D_BPM_UPDATE_EVENT_QUEUE_SV";
drop public synonym "D_BUSINESS_UNITS";
drop public synonym "D_BUSINESS_UNITS_SV";
drop public synonym "D_COMPLAINT_ACTION_COMMENTS";
drop public synonym "D_COMPLAINT_ACTION_COMMENTS_SV";
drop public synonym "D_COMPLAINT_CURRENT";
drop public synonym "D_COMPLAINT_CURRENT_SV";
drop public synonym "D_COMPLAINT_INCIDENT_ABOUT";
drop public synonym "D_COMPLAINT_INCIDENT_ABOUT_SV";
drop public synonym "D_COMPLAINT_INCIDENT_DESC";
drop public synonym "D_COMPLAINT_INCIDENT_DESC_SV";
drop public synonym "D_COMPLAINT_INCIDENT_REASON";
drop public synonym "D_COMPLAINT_INCIDENT_REASON_SV";
drop public synonym "D_COMPLAINT_INCIDENT_STATUS";
drop public synonym "D_COMPLAINT_INCIDENT_STATUS_SV";
drop public synonym "D_COMPLAINT_INSTANCE_STATUS";
drop public synonym "D_COMPLAINT_INSTANCE_STATUS_SV";
drop public synonym "D_COMPLAINT_RESOLUTION_DESC";
drop public synonym "D_COMPLAINT_RESOLUTION_DESC_SV";
drop public synonym "D_COMPLAINT_SLA_SATISFIED";
drop public synonym "D_COMPLAINT_SLA_SATISFIED_SV";
drop public synonym "D_DATES";
drop public synonym "D_INCIDENT_STATUS_HISTORY_SV";
drop public synonym "D_MW_CURRENT";
drop public synonym "D_MW_CURRENT_SV";
drop public synonym "D_MW_ESCALATED";
drop public synonym "D_MW_ESCALATED_SV";
drop public synonym "D_MW_FORWARDED";
drop public synonym "D_MW_FORWARDED_SV";
drop public synonym "D_MW_LAST_UPDATE_BY_NAME";
drop public synonym "D_MW_LAST_UPDATE_BY_NAME_SV";
drop public synonym "D_MW_OWNER";
drop public synonym "D_MW_OWNER_SV";
drop public synonym "D_MW_REFERENCE_CURRENT_SV";
drop public synonym "D_MW_TASK_STATUS";
drop public synonym "D_MW_TASK_STATUS_SV";
drop public synonym "D_MW_TASK_TYPE";
drop public synonym "D_MW_TASK_TYPE_SV";
drop public synonym "D_MW_V2_CURRENT";
drop public synonym "D_MW_V2_CURRENT_SV";
drop public synonym "D_MW_V2_HISTORY";
drop public synonym "D_MW_V2_HISTORY_SV";
drop public synonym "D_MW_V2_INCIDENT_CURR_SV";
drop public synonym "D_NYEC_BPM_DATA_MODEL_SV";
drop public synonym "D_NYEC_BPM_SOURCE_LKUP_SV";
drop public synonym "D_NYEC_BUEQ_SV";
drop public synonym "D_NYEC_PAMI_CURRENT";
drop public synonym "D_NYEC_PAMI_CURRENT_SV";
drop public synonym "D_NYEC_PAMI_ITEM_STATUS";
drop public synonym "D_NYEC_PAMI_ITEM_STATUS_PER";
drop public synonym "D_NYEC_PAMI_ITEM_STATUS_PER_SV";
drop public synonym "D_NYEC_PAMI_ITEM_STATUS_SV";
drop public synonym "D_NYEC_PAMI_RFE_STATUS";
drop public synonym "D_NYEC_PAMI_RFE_STATUS_SV";
drop public synonym "D_NYEC_PA_APP_STATUS";
drop public synonym "D_NYEC_PA_APP_STATUS_SV";
drop public synonym "D_NYEC_PA_CIN";
drop public synonym "D_NYEC_PA_CIN_SV";
drop public synonym "D_NYEC_PA_COUNTY";
drop public synonym "D_NYEC_PA_COUNTY_SV";
drop public synonym "D_NYEC_PA_CURRENT";
drop public synonym "D_NYEC_PA_CURRENT_SV";
drop public synonym "D_NYEC_PA_CURRENT_TASK_SV";
drop public synonym "D_NYEC_PA_DATA_ENTRY_TASK_SV";
drop public synonym "D_NYEC_PA_FPBP_SUBTYPE";
drop public synonym "D_NYEC_PA_FPBP_SUBTYPE_SV";
drop public synonym "D_NYEC_PA_HEART_CASE_STATUS";
drop public synonym "D_NYEC_PA_HEART_CASE_STATUS_SV";
drop public synonym "D_NYEC_PA_HEART_INC_APP_IND";
drop public synonym "D_NYEC_PA_HEART_INC_APP_IND_SV";
drop public synonym "D_NYEC_PA_HEART_SYNCH";
drop public synonym "D_NYEC_PA_HEART_SYNCH_SV";
drop public synonym "D_NYEC_PA_MA_REASON";
drop public synonym "D_NYEC_PA_MA_REASON_SV";
drop public synonym "D_NYEC_PA_MODE_CODE";
drop public synonym "D_NYEC_PA_MODE_CODE_SV";
drop public synonym "D_NYEC_PA_MODE_LABEL";
drop public synonym "D_NYEC_PA_MODE_LABEL_SV";
drop public synonym "D_NYEC_PA_OUTCOME_NOTF_FLAG";
drop public synonym "D_NYEC_PA_OUTCOME_NOTF_FLG_SV";
drop public synonym "D_NYEC_PA_OUTCOM_LTR_STATUS";
drop public synonym "D_NYEC_PA_OUTCOM_LTR_STATUS_SV";
drop public synonym "D_NYEC_PA_QC_INDICATOR";
drop public synonym "D_NYEC_PA_QC_INDICATOR_SV";
drop public synonym "D_NYEC_PA_QC_TASK_SV";
drop public synonym "D_NYEC_PA_REACTIVATED_BY";
drop public synonym "D_NYEC_PA_REACTIVATED_BY_SV";
drop public synonym "D_NYEC_PA_REACTIVATE_REASON";
drop public synonym "D_NYEC_PA_REACTIVATE_REASON_SV";
drop public synonym "D_NYEC_PA_REACTIVATION_IND";
drop public synonym "D_NYEC_PA_REACTIVATION_IND_SV";
drop public synonym "D_NYEC_PA_REACTIVATION_NUM";
drop public synonym "D_NYEC_PA_REACTIVATION_NUM_SV";
drop public synonym "D_NYEC_PA_REV_CLEAR_REASON";
drop public synonym "D_NYEC_PA_REV_CLEAR_REASON_SV";
drop public synonym "D_NYEC_PA_STATE_REV_TASK_SV";
drop public synonym "D_NYEC_PA_WORKFLOW_REAC_IND";
drop public synonym "D_NYEC_PA_WORKFLOW_REAC_IND_SV";
drop public synonym "D_NYEC_PBQJB_SV";
drop public synonym "D_NYEC_PBQJ_SV";
drop public synonym "D_NYEC_PMI_APP_ID";
drop public synonym "D_NYEC_PMI_APP_ID_SV";
drop public synonym "D_NYEC_PMI_CURRENT";
drop public synonym "D_NYEC_PMI_CURRENT_APP_SV";
drop public synonym "D_NYEC_PMI_CURRENT_SV";
drop public synonym "D_NYEC_PMI_CURRENT_TASK_SV";
drop public synonym "D_NYEC_PMI_INBOUND_MI_TYPE";
drop public synonym "D_NYEC_PMI_INBOUND_MI_TYPE_SV";
drop public synonym "D_NYEC_PMI_LETTER_STATUS";
drop public synonym "D_NYEC_PMI_LETTER_STATUS_SV";
drop public synonym "D_NYEC_PMI_MI_TASK_SV";
drop public synonym "D_NYEC_PMI_PENDING_MI_TYPE";
drop public synonym "D_NYEC_PMI_PENDING_MI_TYPE_SV";
drop public synonym "D_NYEC_PMI_QC_TASK_ID";
drop public synonym "D_NYEC_PMI_QC_TASK_ID_SV";
drop public synonym "D_NYEC_PMI_QC_TASK_SV";
drop public synonym "D_NYEC_PMI_RESEARCH_REASON";
drop public synonym "D_NYEC_PMI_RESEARCH_REASON_SV";
drop public synonym "D_NYEC_PMI_RESEARCH_TASK_ID";
drop public synonym "D_NYEC_PMI_RESEARCH_TASK_ID_SV";
drop public synonym "D_NYEC_PMI_RESEARCH_TASK_SV";
drop public synonym "D_NYEC_PMI_STATE_RVW_TASK_SV";
drop public synonym "D_NYEC_PMI_ST_REV_TASK_ID";
drop public synonym "D_NYEC_PMI_ST_REV_TASK_ID_SV";
drop public synonym "D_NYEC_SR_APP_STATUS_GROUP";
drop public synonym "D_NYEC_SR_APP_STATUS_GROUP_SV";
drop public synonym "D_NYEC_SR_CURRENT";
drop public synonym "D_NYEC_SR_CURRENT_APP_SV";
drop public synonym "D_NYEC_SR_CURRENT_SV";
drop public synonym "D_NYEC_SR_CURRENT_TASK_SV";
drop public synonym "D_NYEC_SR_DATA_CORRECT_TASK_SV";
drop public synonym "D_NYEC_SR_HEART_APP_STATUS";
drop public synonym "D_NYEC_SR_HEART_APP_STATUS_SV";
drop public synonym "D_NYEC_SR_RESEARCH_TASK_SV";
drop public synonym "D_NYEC_SR_RFE_STATUS_FLAG";
drop public synonym "D_NYEC_SR_RFE_STATUS_FLAG_SV";
drop public synonym "D_NYEC_SR_STATE_ACCEPT_IND";
drop public synonym "D_NYEC_SR_STATE_ACCEPT_IND_SV";
drop public synonym "D_NYEC_SR_STATE_REV_TASK_SV";
drop public synonym "D_OPS_GROUP_TASK";
drop public synonym "D_PROCESS_BPM_QUEUE_JOB_BAT_SV";
drop public synonym "D_PROCESS_BPM_QUEUE_JOB_SV";
drop public synonym "D_STAFF";
drop public synonym "D_STAFF_SV";
drop public synonym "D_TASK_TYPES";
drop public synonym "D_TASK_TYPES_SV";
drop public synonym "D_TEAMS";
drop public synonym "D_TEAMS_SV";
drop public synonym "ETL_COMMON";
drop public synonym "F_COMPLAINT_BY_DATE";
drop public synonym "F_COMPLAINT_BY_DATE_SV";
drop public synonym "F_MW_BY_DATE";
drop public synonym "F_MW_BY_DATE_SV";
drop public synonym "F_MW_V2_BY_DATE_SV";
drop public synonym "F_NYEC_PAMI_BY_DATE";
drop public synonym "F_NYEC_PAMI_BY_DATE_SV";
drop public synonym "F_NYEC_PA_BY_DATE";
drop public synonym "F_NYEC_PA_BY_DATE_BCK";
drop public synonym "F_NYEC_PA_BY_DATE_SV";
drop public synonym "F_NYEC_PMI_BY_DATE";
drop public synonym "F_NYEC_PMI_BY_DATE_SV";
drop public synonym "F_NYEC_SITP_BY_DATE_BCK";
drop public synonym "F_NYEC_SR_BY_DATE";
drop public synonym "F_NYEC_SR_BY_DATE_SV";
drop public synonym "GET_BUS_DATE";
drop public synonym "GET_INLIST_STR2";
drop public synonym "GET_INLIST_STR3";
drop public synonym "GET_WEEKDAY";
drop public synonym "GROUPS_STG";
drop public synonym "GROUP_STEP_DEFINITION_STG";
drop public synonym "GROUP_STEP_DEFN_DEFAULT_STG";
drop public synonym "HOLIDAYS";
drop public synonym "INCIDENT_HEADER_STAT_HIST_STG";
drop public synonym "LETTERS_STG";
drop public synonym "MAINTAIN_BPM_D_DATES";
drop public synonym "MANAGE_WORK";
drop public synonym "MAXDAT_ADMIN";
drop public synonym "MAXDAT_ADMIN_AUDIT_LOGGING";
drop public synonym "MI_CAMPAIGN_STG";
drop public synonym "MI_DOCS_STG";
drop public synonym "MONITOR_RENEWAL_STG";
drop public synonym "MW_STEP_INSTANCE_VW";
drop public synonym "MW_V2";
drop public synonym "MW_V2_STEP_INSTANCE_VW";
drop public synonym "NYEC_ETL_MANAGE_WORK_REFERENCE";
drop public synonym "NYEC_ETL_MONITOR_RENEWAL";
drop public synonym "NYEC_ETL_MONITOR_RENEWAL_TMP";
drop public synonym "NYEC_ETL_PROCESS_APP";
drop public synonym "NYEC_ETL_PROCESS_APP_MI";
drop public synonym "NYEC_ETL_PROCESS_MI";
drop public synonym "NYEC_ETL_SENDINFOTRADPART";
drop public synonym "NYEC_ETL_STATE_REVIEW";
drop public synonym "NYEC_PROCESS_APP";
drop public synonym "NYEC_PROCESS_APP_MI";
drop public synonym "NYEC_PROCESS_MI";
drop public synonym "NYEC_PROCESS_STATE_REVIEW";
drop public synonym "PBQJ_ADJUST_REASON";
drop public synonym "PBQJ_ADJUST_REASON_LKUP";
drop public synonym "PROCESS_APP_MI_STG";
drop public synonym "PROCESS_APP_STG";
drop public synonym "PROCESS_BPM_CALC_JOB_CONFIG";
drop public synonym "PROCESS_BPM_QUEUE";
drop public synonym "PROCESS_BPM_QUEUE_JOB";
drop public synonym "PROCESS_BPM_QUEUE_JOB_BATCH";
drop public synonym "PROCESS_BPM_QUEUE_JOB_CONFIG";
drop public synonym "PROCESS_BPM_QUEUE_JOB_CONTROL";
drop public synonym "PROCESS_BPM_QUEUE_JOB_CTRL_CFG";
drop public synonym "PROCESS_COMPLAINTS_INCIDENTS";
drop public synonym "PROCESS_MI_STG";
drop public synonym "PRO_MI_MULTIPLE_QC_RSCH_STRW";
drop public synonym "PRO_MI_STG_TRG";
drop public synonym "REL_MI_APP_SV";
drop public synonym "REL_TASK_APP_SV";
drop public synonym "SEQ_BACE_ID";
drop public synonym "SEQ_BAST_ID";
drop public synonym "SEQ_BA_ID";
drop public synonym "SEQ_BE_ID";
drop public synonym "SEQ_BIA_ID";
drop public synonym "SEQ_BI_ID";
drop public synonym "SEQ_BKD_ID";
drop public synonym "SEQ_BKRE_ID";
drop public synonym "SEQ_BKSE_ID";
drop public synonym "SEQ_BL_ID";
drop public synonym "SEQ_BUEQ_ID";
drop public synonym "SEQ_BUE_ID";
drop public synonym "SEQ_CECI_ID";
drop public synonym "SEQ_CEEL_ID";
drop public synonym "SEQ_CELL_ID";
drop public synonym "SEQ_CEMR";
drop public synonym "SEQ_CEMW_ID";
drop public synonym "SEQ_CEMW_V2_ID";
drop public synonym "SEQ_CEPAM";
drop public synonym "SEQ_CEPA_ID";
drop public synonym "SEQ_DCMPLAC_ID";
drop public synonym "SEQ_DCMPLIA_ID";
drop public synonym "SEQ_DCMPLID_ID";
drop public synonym "SEQ_DCMPLIN_ID";
drop public synonym "SEQ_DCMPLIR_ID";
drop public synonym "SEQ_DCMPLIS_ID";
drop public synonym "SEQ_DCMPLRD_ID";
drop public synonym "SEQ_DCMPLSS_ID";
drop public synonym "SEQ_DMWBD_ID";
drop public synonym "SEQ_DMWE_ID";
drop public synonym "SEQ_DMWF_ID";
drop public synonym "SEQ_DMWLUBN_ID";
drop public synonym "SEQ_DMWO_ID";
drop public synonym "SEQ_DMWTS_ID";
drop public synonym "SEQ_DMWTT_ID";
drop public synonym "SEQ_DNPAAS_ID";
drop public synonym "SEQ_DNPACIN_ID";
drop public synonym "SEQ_DNPACOU_ID";
drop public synonym "SEQ_DNPAFPBPST_ID";
drop public synonym "SEQ_DNPAHCS_ID";
drop public synonym "SEQ_DNPAHIAI_ID";
drop public synonym "SEQ_DNPAHS_ID";
drop public synonym "SEQ_DNPAMAR_ID";
drop public synonym "SEQ_DNPAMC_ID";
drop public synonym "SEQ_DNPAMIISP_ID";
drop public synonym "SEQ_DNPAMIIS_ID";
drop public synonym "SEQ_DNPAMIRS_ID";
drop public synonym "SEQ_DNPAML_ID";
drop public synonym "SEQ_DNPAOLS_ID";
drop public synonym "SEQ_DNPAONF_ID";
drop public synonym "SEQ_DNPAQI_ID";
drop public synonym "SEQ_DNPARB_ID";
drop public synonym "SEQ_DNPARCR_ID";
drop public synonym "SEQ_DNPARI_ID";
drop public synonym "SEQ_DNPARN_ID";
drop public synonym "SEQ_DNPARR_ID";
drop public synonym "SEQ_DNPAWRI_ID";
drop public synonym "SEQ_DNPMIAI_ID";
drop public synonym "SEQ_DNPMIIMIT_ID";
drop public synonym "SEQ_DNPMILS_ID";
drop public synonym "SEQ_DNPMIPMIT_ID";
drop public synonym "SEQ_DNPMIQTI_ID";
drop public synonym "SEQ_DNPMIRR_ID";
drop public synonym "SEQ_DNPMIRTI_ID";
drop public synonym "SEQ_DNPMISRTI_ID";
drop public synonym "SEQ_DNSRASG_ID";
drop public synonym "SEQ_DNSRHAS_ID";
drop public synonym "SEQ_DNSRRSF_ID";
drop public synonym "SEQ_DNSRSAI_ID";
drop public synonym "SEQ_FCMPLBD_ID";
drop public synonym "SEQ_FMWBD_ID";
drop public synonym "SEQ_FNPABD_ID";
drop public synonym "SEQ_FNPAMIBD_ID";
drop public synonym "SEQ_FNPMIBD_ID";
drop public synonym "SEQ_FNSRBD_ID";
drop public synonym "SEQ_HOLIDAY_ID";
drop public synonym "SEQ_JOB_ID";
drop public synonym "SEQ_MAAL_ID";
drop public synonym "SEQ_MCES";
drop public synonym "SEQ_NEMWR_ID";
drop public synonym "SEQ_NEPM";
drop public synonym "SEQ_NESR";
drop public synonym "SEQ_PBCJC_ID";
drop public synonym "SEQ_PBQJB_ID";
drop public synonym "SEQ_PBQJC_ID";
drop public synonym "SEQ_PBQJ_ID";
drop public synonym "SEQ_PMS_ID";
drop public synonym "SEQ_PROCESS_BUEQ_ID";
drop public synonym "SEQ_SITP";
drop public synonym "STAFF_KEY_LKUP";
drop public synonym "STAFF_LKUP";
drop public synonym "STAFF_STG";
drop public synonym "STATE_REVIEW_STG";
drop public synonym "STATE_REVIEW_STG_TMP";
drop public synonym "STEP_DEFINITION_STG";
drop public synonym "STEP_INSTANCE_STG";
drop public synonym "SVN_REVISION_DEPLOYED";
drop public synonym "SVN_REVISION_KEYWORD";
drop public synonym "T0ACYLQYUMQ001";
drop public synonym "T15B8CSN3MD003";
drop public synonym "T1LNC0S59MQ000";
drop public synonym "T1Y96P3MHOL000";
drop public synonym "T4M0RE6MGOL000";
drop public synonym "T5510LQ1BOL004";
drop public synonym "T56GBRSE9MQ000";
drop public synonym "T5IJ3TCOJMD003";
drop public synonym "T7A3JCA77MQ001";
drop public synonym "T7EQWXSMPOL004";
drop public synonym "T86UMG8YCOL000";
drop public synonym "T8P38D32NMQ001";
drop public synonym "T96U04RDRMD000";
drop public synonym "TAU9ISX2HMQ000";
drop public synonym "TBQWVC7W3MD002";
drop public synonym "TFEQWR0UPMD003";
drop public synonym "TFRKCX8TLOL000";
drop public synonym "TIU5TAIE8OL000";
drop public synonym "TJASV0WKJOL004";
drop public synonym "TL5D3GM5LMQ000";
drop public synonym "TNTOKDAWFMD002";
drop public synonym "TO92SRUINMQ000";
drop public synonym "TQ2CORBJLMQ001";
drop public synonym "TRG_ADIU_CORP_ETL_LIST_LKUP";
drop public synonym "TRG_ADIU_HOLIDAYS";
drop public synonym "TRG_AI_CORP_ETL_COMPLAINTS_Q";
drop public synonym "TRG_AI_CORP_ETL_MANAGE_WORK_Q";
drop public synonym "TRG_AI_CORP_ETL_MW_V2_Q";
drop public synonym "TRG_AI_NYEC_ETL_PA_MI_Q";
drop public synonym "TRG_AI_NYEC_ETL_PROCESS_APP_Q";
drop public synonym "TRG_AI_NYEC_ETL_PROCESS_MI_Q";
drop public synonym "TRG_AI_NYEC_ETL_STATE_REVIEW_Q";
drop public synonym "TRG_AU_CORP_ETL_COMPLAINTS_Q";
drop public synonym "TRG_AU_CORP_ETL_MANAGE_WORK_Q";
drop public synonym "TRG_AU_CORP_ETL_MW_V2_Q";
drop public synonym "TRG_AU_NYEC_ETL_PA_MI_Q";
drop public synonym "TRG_AU_NYEC_ETL_PROCESS_APP_Q";
drop public synonym "TRG_AU_NYEC_ETL_PROCESS_MI_Q";
drop public synonym "TRG_AU_NYEC_ETL_STATE_REVIEW_Q";
drop public synonym "TRG_BIU_BPM_ACTIVITY_EVENTS";
drop public synonym "TRG_BIU_BPM_ATTRIBUTE";
drop public synonym "TRG_BIU_BPM_INSTANCE";
drop public synonym "TRG_BIU_BPM_INSTANCE_ATTR";
drop public synonym "TRG_BIU_BPM_UPDATE_EVENT";
drop public synonym "TRG_BIU_CORP_ETL_CONTROL";
drop public synonym "TRG_BIU_CORP_ETL_ERROR_LOG";
drop public synonym "TRG_BIU_CORP_ETL_LIST_LKUP";
drop public synonym "TRG_BIU_CORP_ETL_MANAGE_WORK";
drop public synonym "TRG_BIU_CORP_ETL_MW_V2";
drop public synonym "TRG_BIU_NYEC_ETL_MW_REFERENCE";
drop public synonym "TRG_BIU_NYEC_ETL_SENDINFOTP";
drop public synonym "TRG_BIU_R_HOLIDAYS";
drop public synonym "TRG_BIU_STEP_INSTANCE_STG";
drop public synonym "TRG_BPM_KOFAX_RELEASE_EVENTS";
drop public synonym "TRG_CC_EVENT_STG";
drop public synonym "TRG_NYEC_ETL_STRW_STG";
drop public synonym "TRG_R_BIU_BPM_BKD";
drop public synonym "TRG_R_BIU_BPM_BKSE";
drop public synonym "TRG_R_CORP_ETL_COMPLAINTS";
drop public synonym "TRG_R_CORP_ETL_MANAGE_WORK";
drop public synonym "TRG_R_NYEC_ETL_MONITOR_RENEWAL";
drop public synonym "TRG_R_NYEC_ETL_PROCESS_APP";
drop public synonym "TRG_R_NYEC_ETL_PROCESS_APP_MI";
drop public synonym "TRG_R_NYEC_ETL_PROCESS_MI";
drop public synonym "TRG_STATE_REVIEW_STG";
drop public synonym "TRG_STATE_REVIEW_STG_TMP";
drop public synonym "TUH6H5QXLMQ000";
drop public synonym "TUYFSSCLDMQ000";
drop public synonym "TVELKR1G1MD002";
drop public synonym "TVQDBCASJMQ000";
drop public synonym "TXM377AZ8MQ000";
drop public synonym "TZDI8HR8CMQ000";