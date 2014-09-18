***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB 
----------------
2013/09/07 B.Thai - Creation.

******************************************************************************************************

-----------------------
1. DB SCRIPTS SECTION
-----------------------

        execute PROCESS_BPM_QUEUE_JOB_CONTROL.SHUTDOWN_JOBS;

	-- Run these SQL scripts below as the the Oracle user MAXDAT:  
	-- (or as a proxy login to MAXDAT - Example: rk50472[maxdat])

	-- All files can be found at:		
	-- svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/SupportClientInquiry/patch
	-- or DB_SCI_20130916_BRIAN_4.zip

        20130911_1344_alter_CLIENT_INQUIRY_tables.sql
        20130911_1227_recompile_SCI_ETL_triggers.sql
        20130911_1345_reset_SCI_ctl_for_trigger.sql
        20130916_1014_update_etl_ASPB_HANDLE_CONTACT.sql

        execute PROCESS_BPM_QUEUE_JOB_CONTROL.STARTUP_JOBS;


------------------------------
2. Support Client Inquiry kettle files
------------------------------
Download AS_SCI_20130916_BRIAN_4
and deploy to <MAXDAT_ETL_PATH> /SupportClientInquiry directory

svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/ETL/scripts/SupportClientInquiry/
ClientInquiry_Main_Insert_Rules_TX.ktr
ClientInquiry_Main_Update_UPD1_10_TX.ktr

 






