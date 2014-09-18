***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB 
----------------
2013/16/06 Abdul Farhan - Creation.

******************************************************************************************************

-----------------------
1. DB SCRIPTS SECTION
-----------------------
	-- Run these SQL scripts below as the the Oracle user MAXDAT:  
	-- (or as a proxy login to MAXDAT - Example: rk50472[maxdat])

	-- All files can be found at:					
	-- svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/ClientOutreach/createdb
	-- or DB_ClientOutreach_20130906_ABDUL_1_CORP.zip

        create_ETL_ClientOutreach_tables.sql
        create_ETL_ClientOutreach_sequences.sql  
        create_ETL_ClientOutreach_triggers.sql
        populate_CORP_ETL_CONTROL.sql
        populate_CORP_ETL_LIST_LKUP.sql
        populate_lkup_tables.sql
        populate_BPM_ATTRIBUTE_LKUP.sql
        populate_BPM_ATTRIBUTE.sql
        populate_BPM_ATTRIBUTE_STAGING_TABLE.sql
        SemanticModel_Client_Outreach.sql
        CLIENT_OUTREACH_pkg.sql

        -- All files can be found at:					
	-- svn://rcmxapp1d.maximus.com/maxdat/BPM/TXEB/ClientOutreach/createdb
	-- or DB_ClientOutreach_20130906_ABDUL_1_TXEB.zip

        populate_BPM_EVENT_MASTER.sql
        populate_CORP_CLNT_OUTREACH_NOTIFY_LKUP.sql
        populate_CORP_CLNT_OUTREACH_PROC_LKUP.sql
        populate_CORP_ETL_CLNT_OR_ACTIVITY_LKUP.sql
        populate_CORP_ETL_CLNT_SURVEY_LKUP.sql



-----------------------
2. KETTLE FILES SECTION
-----------------------
Download AS_ClientOutreach_20130906_ABDUL_1.zip
and deploy to <MAXDAT_ETL_PATH> /ClientOutreach directory

        -- All files can be found at:					
	-- svn://rcmxapp1d.maximus.com/maxdat/trunk/corp/scripts/ClientOutreach


         ClientOutreach_runall.kjb
         Client_Outreach_env_var.ktr
         Client_Outreach_Get_CntrlVariable.ktr
         Client_Outreach_INS1.ktr
         Client_Outreach_INS2.ktr
         Client_Outreach_updMAX_Event_id_ctrlVariable.ktr
         ClientOutreach_OLTP_details.kjb
         Client_Outreach_copy_TEMP.ktr
         Client_Outreach_get_OLTP.ktr
         Client_Outreach_get_OLTP_Validation.ktr
         Client_Outreach_GetOLTP_SUBPROG.kjb 
         Client_Outreach_GetOLTP_SUBPROG_TMP.ktr
         Client_Outreach_GetOLTP_SUBPROG.ktr
         Client_Outreach_get_OLTP_Surveys.ktr
         ClientOutreach_Updates.kjb
         Client_Outreach_UPD1.ktr
         Client_Outreach_UPD2.ktr
         Client_Outreach_UPD3.ktr
         Client_Outreach_ActivityLKUP.ktr
         Client_Outreach_UPD4.ktr
         Client_Outreach_UPD5.ktr
         Client_Outreach_UPD6.ktr
         Client_Outreach_UPD7.ktr
         Client_Outreach_UPD8.ktr
         Client_Outreach_UPD9.ktr
         Client_Outreach_UPD10.ktr
         Client_Outreach_UPD11.ktr
         Client_Outreach_UPD12.ktr
         Client_Outreach_UPD13.ktr
         Client_Outreach_UPD14.ktr
         Client_Outreach_UPD15.ktr
         Client_Outreach_UPD16.ktr
         Client_Outreach_UPD17.ktr
         Client_Outreach_UPD18.ktr
         Client_Outreach_UPD19.ktr
         Client_Outreach_UPD20.ktr
         Client_Outreach_UPD21.ktr
         Client_Outreach_UPD24.ktr
         Client_Outreach_UPD25.ktr
         Client_Outreach_UPD_BPM_Main.ktr
         Client_Outreach_updMAX_ctrlVariable.ktr
         Client_Outreach_MainJob_completed.ktr


