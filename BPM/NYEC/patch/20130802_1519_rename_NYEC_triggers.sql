-- Standardize trigger names.

-- Errors OK, not all triggers may exist on all installs, depending on completeness of earlier install.

-- Processes
alter trigger "TRG_R_CORP_ETL_MANAGE_WORK" rename to TRG_BIU_CORP_ETL_MANAGE_WORK;