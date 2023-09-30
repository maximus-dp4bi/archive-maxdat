-- Standardize trigger names.

-- Errors OK, not all triggers may exist on all install, depending on completeness of earlier install.

alter trigger TRG_R_AIUD_ETL_LIST_LKUP_HIST rename to TRG_ADIU_CORP_ETL_LIST_LKUP;