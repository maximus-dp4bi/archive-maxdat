-- Standardize trigger names.

-- Errors OK, not all triggers may exist on all installs, depending on completeness of earlier install.

-- BPM Event
alter trigger TRG_R_BIU_BPM_ACTIVITY_EVENTS rename to TRG_BIU_BPM_ACTIVITY_EVENTS;
alter trigger TRG_R_BIU_BPM_ATTRIBUTE rename to TRG_BIU_BPM_ATTRIBUTE;
alter trigger TRG_R_BIU_BPM_INSTANCE rename to TRG_BIU_BPM_INSTANCE;
alter trigger TRG_R_BIU_BPM_UPDATE_EVENT rename to TRG_BIU_BPM_UPDATE_EVENT;

-- ETL
alter trigger TR_CORP_ETL_CLEAN_TABLE_HS rename to TRG_ADIU_CORP_ETL_CLEAN;
alter trigger "cect_biur_trg" rename to TRG_BIU_CORP_ETL_CLEAN;
alter trigger "TRG_cec" rename to TRG_BIU_CORP_ETL_CONTROL;
alter trigger TRG_BIUR_CORP_ETL_ERROR_LOG rename to TRG_BIU_CORP_ETL_ERROR_LOG;
alter trigger TRG_R_ETL_LIST_LKUP rename to TRG_BIU_CORP_ETL_LIST_LKUP;
alter trigger CORP_INSTANCE_CLEANUP_TABLE rename to TRG_BIU_CORP_INSTANCE_CLEANUP;
alter trigger TRG_R_AIUD_ETL_LIST_LKUP_HIST rename to TRG_ADIU_CORP_ETL_LIST_LKUP;

-- Processes
alter trigger "TRG_R_CORP_ETL_MANAGE_WORK" rename to TRG_BIU_CORP_ETL_MANAGE_WORK;