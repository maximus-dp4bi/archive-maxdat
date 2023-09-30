/*
Created on 07/25/2016 by Raj A.
Description: MAXDAT-3691. Created for CADRMXDU.

alter session set current_schema = MAXDAT_CADR;

select 'alter index ' || i.INDEX_NAME || ' noparallel; ' altercommand, i.TABLE_NAME
from ALL_INDEXES i
inner join ALL_TABLES t on i.TABLE_NAME = t.TABLE_NAME
where i.OWNER = 'MAXDAT_CADR'
  and t.OWNER = 'MAXDAT_CADR' 
order by i.INDEX_NAME asc;

--After the above sql spits the alter commands with noparallel, manually modify to match the table DOP.
*/
alter index ACTS_APPEAL_CASE_IX1 noparallel; 
alter index ACTS_APPEAL_CASE_IX2 noparallel; 
alter index ACTS_CASE_QUEUE_IX1 noparallel; 
alter index ACTS_CONSL_REF_HSTY_IX1 noparallel; 
alter index ACTS_CONSL_REF_HSTY_IX2 noparallel; 
alter index ACTS_CONSULTANT_REF_IX1 noparallel; 
alter index ACTS_CONSULTANT_REF_IX2 noparallel; 
alter index ACTS_CRED_CONSULTANT_IX1 noparallel; 
alter index ACTS_CRED_LICENSES_IX1 noparallel; 
alter index ACTS_PM_RESPONSE_DETAILS_IX1 noparallel; 
alter index ACTS_PM_RESPONSE_DETAILS_IX2 noparallel; 
alter index ACTS_PM_RESPONSE_IX1 noparallel; 
alter index ACTS_PROGRAM_IX1 noparallel; 
alter index ACTS_REFUSAL_REASON_VALUE_IX1 noparallel; 
alter index ACTS_REVIEW_DECISION_IX1 noparallel; 
alter index ACTS_SPECIALITY_SP_KEY_IX2 noparallel; 
alter index ACTS_SPECIALITY_VALUE_IX1 noparallel; 
alter index ACTS_USERS_IX1 noparallel; 
alter index BACA_UNK noparallel; 
alter index BACL_UNK noparallel; 
alter index BAETL_UNK noparallel; 
alter index BAE_UNK noparallel; 
alter index BAST_BA_ID_IX1 noparallel; 
alter index BAST_PK noparallel; 
alter index BATL_UNK noparallel; 
alter index BD_UNK noparallel; 
alter index BONUS_SCORES_UNIQUE noparallel; 
alter index BPF_UNK noparallel; 
alter index BPM_ACTIVITY_ATTRIBUTE_PK noparallel; 
alter index BPM_ACTIVITY_EVENTS_PK noparallel; 
alter index BPM_ACTIVITY_LKUP_PK noparallel; 
alter index BPM_ACTIVITY_TYPE_LKUP_PK noparallel; 
alter index BPM_ACT_EVENT_TYPE_LKUP_PK noparallel; 
alter index BPM_ATTRIBUTE_LKUP_PK noparallel; 
alter index BPM_ATTRIBUTE_LKUP_UNK noparallel; 
alter index BPM_ATTRIBUTE_PK noparallel; 
alter index BPM_ATTRIBUTE_UNK noparallel; 
alter index BPM_DATATYPE_LKUP_PK noparallel; 
alter index BPM_DATA_MODEL_PK noparallel; 
alter index BPM_D_DATES_PK noparallel; 
alter index BPM_D_HOURS_PK noparallel; 
alter index BPM_D_OPS_GROUP_TASK_PK noparallel; 
alter index BPM_EVENT_MASTER noparallel; 
alter index BPM_EVENT_MASTER_PK noparallel; 
alter index BPM_IDENTIFIER_LKUP_PK noparallel; 
alter index BPM_IDENTIFIER_LKUP_UNK noparallel; 
alter index BPM_LOGGING_LX1 noparallel; 
alter index BPM_LOGGING_LX2 noparallel; 
alter index BPM_LOGGING_PK noparallel; 
alter index BPM_PROCESS_FLOW_PK noparallel; 
alter index BPM_PROCESS_LKUP_PK noparallel; 
alter index BPM_PROCESS_LKUP_UNK noparallel; 
alter index BPM_PROGRAM_LKUP_PK noparallel; 
alter index BPM_PROGRAM_UNK noparallel; 
alter index BPM_PROJECT_UNK noparallel; 
alter index BPM_REGION_LKUP_PK noparallel; 
alter index BPM_REGION_UNK noparallel; 
alter index BPM_SOURCE_LKUP_PK noparallel; 
alter index BPM_SOURCE_LKUP_UNK noparallel; 
alter index BPM_SOURCE_TYPE_LKUP_PK noparallel; 
alter index BPM_UPDATE_TYPE_LKUP_PK noparallel; 
alter index BUEQA_PK noparallel; 
alter index BUEQ_IX1 parallel 2; 
alter index BUEQ_LX1  parallel 2;
alter index BUEQ_LX2  parallel 2; 
alter index BUEQ_LX3  parallel 2; 
alter index BUEQ_LX5  parallel 2; 
alter index BUEQ_PK  parallel 2; 
alter index BUTL_UNK noparallel; 
alter index CADIR_MAXDAT_STG_INDXAS noparallel; 
alter index CADIR_MAXDAT_STG_INDXCN noparallel; 
alter index CADIR_MAXDAT_STG_INDXFR noparallel; 
alter index CADIR_MAXDAT_STG_INDXTO noparallel; 
alter index CADIR_MAXDAT_STG_INDXTR noparallel; 
alter index CADIR_MAXDAT_STG_INXID noparallel; 
alter index CADIR_ROLE_STG_INDXRI noparallel; 
alter index CADIR_USER_STG_INDXPS noparallel; 
alter index CADIR_USER_STG_INDXUS noparallel; 
alter index CASE_NUMBER_INDX noparallel; 
alter index CECTL_PK noparallel; 
alter index CECT_HS_PK noparallel; 
alter index CECT_PK noparallel; 
alter index CLAIM_ADMIN_STATE_ID_FK noparallel; 
alter index CLAIM_PRIORITY_ID_FK noparallel; 
alter index CLIENT_SUPPLEMENTARY_INFO_PK noparallel; 
alter index CLNT_SUPPL_INFO_INDX1 noparallel; 
alter index CLOSED_REASON_ID_FK noparallel; 
alter index CORP_ETL_ERROR_LOG_PK noparallel; 
alter index CORP_ETL_JOB_STATISTICS_PK noparallel; 
alter index CORP_ETL_LIST_LKUP_HIST_PK noparallel; 
alter index CORP_ETL_LIST_LKUP_PK noparallel; 
alter index CORP_ETL_LIST_LKUP_UK noparallel; 
alter index CORP_ETL_MANAGE_WORK_IX1 noparallel; 
alter index CORP_ETL_MANAGE_WORK_TMP_IX1 noparallel; 
alter index CORP_ETL_MANAGE_WORK_TMP_IX2 noparallel; 
alter index CORP_INSTANCE_CLEANUP_IX1 noparallel; 
alter index C_TABLE_INDX noparallel; 
alter index DCCP_PK noparallel; 
alter index DCCP__UN noparallel; 
alter index DCCR_ID_PK noparallel; 
alter index DCCR__UN noparallel; 
alter index DCDD__UN noparallel; 
alter index DCDP_ID_PK noparallel; 
alter index DCDP__UN noparallel; 
alter index DCDT_ID_PK noparallel; 
alter index DCDT__UN noparallel; 
alter index DCD_ID_PK noparallel; 
alter index DCEC_ID_PK noparallel; 
alter index DCEC__UN noparallel; 
alter index DCEL_ID_PK noparallel; 
alter index DCEL__UN noparallel; 
alter index DCES_ID_PK noparallel; 
alter index DCES__UN noparallel; 
alter index DCET_ID_PK noparallel; 
alter index DCET__UN noparallel; 
alter index DCE_ID_PK noparallel; 
alter index DCE__UN noparallel; 
alter index DCIES_ID_PK noparallel; 
alter index DCIES__UN noparallel; 
alter index DCIL_ID_PK noparallel; 
alter index DCIL__UN noparallel; 
alter index DCIR_ID_PK noparallel; 
alter index DCIR__UN noparallel; 
alter index DCIT_ID_PK noparallel; 
alter index DCIT__UN noparallel; 
alter index DCSS__UN noparallel; 
alter index DCS_ID_PK noparallel; 
alter index DCS_PK noparallel; 
alter index DCS__UN noparallel; 
alter index DCTR_ID_PK noparallel; 
alter index DCTR__UN noparallel; 
alter index DELTEK_UNIQUE noparallel; 
alter index DMWCUR_PK  parallel 2; 
alter index DMWCUR_UIX1  parallel 2; 
alter index DMWE_PK noparallel; 
alter index DMWE_UIX1 noparallel; 
alter index DMWF_PK noparallel; 
alter index DMWF_UIX1 noparallel; 
alter index DMWLUBN_PK noparallel; 
alter index DMWLUBN_UIX1 noparallel; 
alter index DMWO_PK noparallel; 
alter index DMWO_UIX1 noparallel; 
alter index DMWTS_PK noparallel; 
alter index DMWTS_UIX1 noparallel; 
alter index DMWTT_PK noparallel; 
alter index DMWTT_UIX1 noparallel; 
alter index DZCZ__UN noparallel; 
alter index DZC_ID_PK noparallel; 
alter index D_HOURS_PK noparallel; 
alter index D_PERSON_LOGIN_NAME_UK noparallel; 
alter index D_PRODUCTION_PLAN_HRZN_PK noparallel; 
alter index D_PRODUCTION_PLAN_HRZN_UN noparallel; 
alter index D_PRODUCTION_PLAN_HRZN_UN1 noparallel; 
alter index D_PRODUCTION_PLAN_PK noparallel; 
alter index D_PRODUCTION_PLAN__UN noparallel; 
alter index D_SEGMENT_UNK noparallel; 
alter index D_STAFF_PK noparallel; 
alter index EDI_CONTRIBUTOR_ID_FK noparallel; 
alter index EXPERT_REVIEW_ID_INDX noparallel; 
alter index EXP_REV_HIST_ID_INDX noparallel; 
alter index EXP_REV_HIST_IMR_ID_INDX noparallel; 
alter index EXP_REV_IMR_ID_INDX noparallel; 
alter index FADIQS_ID_PK noparallel; 
alter index FMWBD_IX1  parallel 2; 
alter index FMWBD_IX2  parallel 2;
alter index FMWBD_IXL1 parallel 2;
alter index FMWBD_IXL2  parallel 2;
alter index FMWBD_IXL3 parallel 2;
alter index FMWBD_IXL4 parallel 2;
alter index FMWBD_IXL5 parallel 2;
alter index FMWBD_IXL6 parallel 2;
alter index FMWBD_PK parallel 2;
alter index FMWBD_UIX1 parallel 2;
alter index FMWBD_UIX2 parallel 2;
alter index FORECAST_MONTH_INDX noparallel; 
alter index FPP_PK noparallel; 
alter index FQNBDS_ID_PK noparallel; 
alter index GROUP_PK noparallel; 
alter index HOLIDAYS_PK noparallel; 
alter index HOLIDAYS_UK1 noparallel; 
alter index IDX_CL_ELIG_STAT_CLIENT_ID noparallel; 
alter index IDX_CL_ELIG_STAT_CREATE_TS noparallel; 
alter index IDX_CL_ELIG_STAT_UPDATE_TS noparallel; 
alter index IDX_MANAGE_WORK_CASE_ID noparallel; 
alter index IDX_MANAGE_WORK_CLIENT_ID noparallel; 
alter index IDX_MANAGE_WORK_TMP_CASE_ID noparallel; 
alter index IDX_MANAGE_WORK_TMP_CLIENT_ID noparallel; 
alter index IDX_MANAGE_WORK_TMP_REF_ID noparallel; 
alter index IDX_SQID_SOURCE_TASK_ID noparallel; 
alter index IDX_SQID_TASK_ID noparallel; 
alter index IDX_STEP_INST_STG_CASE_ID noparallel; 
alter index IDX_STEP_INST_STG_CLIENT_ID noparallel; 
alter index ID_BASE_INDX noparallel; 
alter index IMR_ID_FK noparallel; 
alter index IMR_ID_INDX noparallel; 
alter index INELIGIBLE_LETTER_ID_FK noparallel; 
alter index ISSUE_IN_DISPUTE_ID_INDX noparallel; 
alter index LETTERS_ID_STG_IDX noparallel; 
alter index LETTERS_REQUEST_TYPE_STG_IDX noparallel; 
alter index LETTERS_SENT_ON_STG_IDX noparallel; 
alter index LETTERS_STG_IDX noparallel; 
alter index LETTERS_TYPE_CD_STG_IDX noparallel; 
alter index MAXDAT_ADMIN_AUDIT_LOGGING_IX1 noparallel; 
alter index MAXDAT_ADMIN_AUDIT_LOGGING_PK noparallel; 
alter index MGOAL_ID_IX1 noparallel; 
alter index MW_TG_ID_PK noparallel; 
alter index M_FRCST_ID_PK noparallel; 
alter index PBCJC_PK noparallel; 
alter index PBCJC_UX1 noparallel; 
alter index PBQJB_LX1 noparallel; 
alter index PBQJB_LX2 noparallel; 
alter index PBQJB_PK noparallel; 
alter index PBQJC_PK noparallel; 
alter index PBQJC_UX1 noparallel; 
alter index PBQJ_ADJUST_REASON_LKUP_PK noparallel; 
alter index PBQJ_ADJUST_REASON_LKUP_UX1 noparallel; 
alter index PBQJ_IX1 noparallel; 
alter index PBQJ_IX2 noparallel; 
alter index PBQJ_PK noparallel; 
alter index PBQJ_UX1 noparallel; 
alter index PK_BPM_PROJECT_LKUP noparallel; 
alter index PK_CLNT_ELIG_STAT_ID noparallel; 
alter index PK_D_SEGMENT_LKUP noparallel; 
alter index PK_PP_D_PROJECT noparallel; 
alter index PP_CFG_ACTUALS_FILE_CTRL_PK noparallel; 
alter index PP_CFG_ACTUALS_FILE_CTRL_UN noparallel; 
alter index PP_CFG_FRCST_FILE_CONTROL_IDX noparallel; 
alter index PP_CFG_FRCST_FILE_CONTROL_PK noparallel; 
alter index PP_CFG_HORIZON_PK noparallel; 
alter index PP_CFG_HORIZON_UN noparallel; 
alter index PP_CFG_HORIZON_UN1 noparallel; 
alter index PP_CFG_PROD_PLAN_PK noparallel; 
alter index PP_CFG_PROD_PLAN_UN noparallel; 
alter index PP_CFG_PROD_PLAN_UN1 noparallel; 
alter index PP_CFG_PROGRAM_CONFIG_PK noparallel; 
alter index PP_CFG_PROGRAM_CONFIG_UNK noparallel; 
alter index PP_CFG_PROJECT_CONFIG_PK noparallel; 
alter index PP_CFG_PROJECT_PK noparallel; 
alter index PP_CFG_PROJECT_UN noparallel; 
alter index PP_CFG_SOURCE_CONFIG_PK noparallel; 
alter index PP_CFG_SOURCE_CONFIG_UNK noparallel; 
alter index PP_CFG_UNIT_OF_WORK_PK noparallel; 
alter index PP_CFG_UNIT_OF_WORK_UK1 noparallel; 
alter index PP_D_ACTUAL_DETAILS_PK noparallel; 
alter index PP_D_COUNTRY_NAME_UN noparallel; 
alter index PP_D_COUNTRY_PK noparallel; 
alter index PP_D_DATES_D_WEEK_OF_MONTH_IX noparallel; 
alter index PP_D_DATES_MONTH_NAME_IX noparallel; 
alter index PP_D_DATES_PK noparallel; 
alter index PP_D_DISTRICT_NAME_UN noparallel; 
alter index PP_D_DISTRICT_PK noparallel; 
alter index PP_D_GEOGRAPHY_LKUP_NAME_UN noparallel; 
alter index PP_D_GEOGRAPHY_MASTER_PK noparallel; 
alter index PP_D_GEOGRAPHY_MASTER__UN noparallel; 
alter index PP_D_HOURS_UN noparallel; 
alter index PP_D_HOURS_UN1 noparallel; 
alter index PP_D_HOURS_UN2 noparallel; 
alter index PP_D_PROGRAM_PK noparallel; 
alter index PP_D_PROGRAM_UNK noparallel; 
alter index PP_D_PROJECT_UNK noparallel; 
alter index PP_D_PROVINCE_NAME_UK noparallel; 
alter index PP_D_PROVINCE_PK noparallel; 
alter index PP_D_REGION_PK noparallel; 
alter index PP_D_REGION_UNK noparallel; 
alter index PP_D_SITE_PK noparallel; 
alter index PP_D_SITE_SITE_NAME_UN noparallel; 
alter index PP_D_SOURCE_PK noparallel; 
alter index PP_D_SOURCE_REF_TYPE_PK noparallel; 
alter index PP_D_SOURCE_REF_TYPE_UN noparallel; 
alter index PP_D_SOURCE__UN noparallel; 
alter index PP_D_STATE_PK noparallel; 
alter index PP_D_STATE__UN noparallel; 
alter index PP_D_UNIT_OF_WORK_PK noparallel; 
alter index PP_D_UNIT_OF_WORK_UK1 noparallel; 
alter index PP_D_UOW_SOURCE_REF_PK noparallel; 
alter index PP_D_UOW_SOURCE_REF_UN noparallel; 
alter index PP_D_UOW_SOURCE_REF_UN1 noparallel; 
alter index PP_FORECAST_NOTES_PK noparallel; 
alter index PP_F_ACTUALS_IDX noparallel; 
alter index PP_F_ACTUALS_UN noparallel; 
alter index PP_F_FORECAST_UN noparallel; 
alter index PP_STG_ACTUALS_PK noparallel; 
alter index PP_STG_FORECAST_PK noparallel; 
alter index PP_STG_FORECAST_UN noparallel; 
alter index PP_STG_FORECAST_UN1 noparallel; 
alter index PP_STG_LOG_PK noparallel; 
alter index SCICS_ID_PK noparallel; 
alter index SCICS__UN noparallel; 
alter index SCIELS_ID_PK noparallel; 
alter index SCIELS__UN noparallel; 
alter index STEP_INSTANCE_STG_PK noparallel; 
alter index STEP_INS_INDX1 noparallel; 
alter index STEP_INS_INDX2 noparallel; 
alter index STEP_INS_INDX3 noparallel; 
alter index SYS_C004681 noparallel; 
alter index SYS_C004684 noparallel; 
alter index SYS_C004685 noparallel; 
alter index SYS_C004686 noparallel; 
alter index SYS_C004698 noparallel; 
alter index SYS_C004718 noparallel; 
alter index SYS_C004720 noparallel; 
alter index SYS_C004721 noparallel; 
alter index SYS_C004723 noparallel; 
alter index SYS_C004739 noparallel; 
alter index SYS_C004760 noparallel; 
alter index SYS_C004792 noparallel; 
alter index SYS_C004793 noparallel; 
alter index SYS_C004821 noparallel; 
alter index SYS_C004824 noparallel; 
alter index SYS_C004854 noparallel; 
alter index SYS_C004855 noparallel; 
alter index S_CRS_ID_PK noparallel; 
alter index S_CRS_IER_PK noparallel; 
alter index S_CRS_IIID_PK noparallel; 
alter index S_CRS_IMR_AUDIT_PK noparallel; 
alter index S_CRS_IMR_PK noparallel; 
alter index S_CRS_IMR_PRELIM_REV_PK noparallel; 
alter index UNQ_DAY_INEXPERT_QUEUE noparallel; 
alter index UNQ_DAY_WITH_EXPERT noparallel; 
alter index XPKGROUP_STEP_DEFINITION noparallel; 
alter index XPKGROUP_STEP_DEFN_DEFAULT noparallel; 
alter index XPKSTEP_DEFINITION_STG noparallel;