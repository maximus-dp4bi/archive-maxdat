-- Standardize trigger names.

-- Errors OK, not all triggers may exist on all installs, depending on completeness of earlier install.

-- Processes
alter trigger "TRG_R_CORP_ETL_MANAGE_JOBS" rename to TRG_BIU_CORP_ETL_MANAGE_JOBS;
alter trigger "TRG_R_CORP_ETL_MANAGE_WORK" rename to TRG_BIU_CORP_ETL_MANAGE_WORK;
alter trigger "TRG_BIU_CORP_ETL_PRCES_INCDNTS" rename to TRG_BIU_CORP_ETL_PROC_INCDNTS;
alter trigger TRG_R_corp_etl_PROC_LETTER rename to TRG_BIU_corp_etl_PROC_LETTER;
alter trigger TRG_R_corp_etl_mailfaxdoc rename to TRG_BIU_CORP_ETL_MAILFAXDOC;
