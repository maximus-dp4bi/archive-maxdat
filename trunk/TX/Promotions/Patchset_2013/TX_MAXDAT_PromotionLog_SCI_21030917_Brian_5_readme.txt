***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB 
----------------
2013/09/17 B.Thai - Creation.

******************************************************************************************************

-----------------------
1. DB SCRIPTS SECTION
-----------------------

        execute PROCESS_BPM_QUEUE_JOB_CONTROL.SHUTDOWN_JOBS;

	-- Run these SQL scripts below as the the Oracle user MAXDAT:  
	-- (or as a proxy login to MAXDAT - Example: rk50472[maxdat])

	-- All files can be found at:		
	-- svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/SupportClientInquiry/patch
	-- or DB_SCI_20130917_BRIAN_5.zip

        20130917_1421_recompile_SCI_ETL_event_trg.sql
        20130916_1014_update_etl_ASPB_HANDLE_CONTACT.sql

        execute PROCESS_BPM_QUEUE_JOB_CONTROL.STARTUP_JOBS;


------------------------------
2. Support Client Inquiry kettle files
------------------------------
Download AS_SCI_20130917_BRIAN_5
and deploy to <MAXDAT_ETL_PATH> /SupportClientInquiry directory

svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/ETL/scripts/SupportClientInquiry/
ClientInquiry_Main_Insert_Rules_TX.ktr
ClientInquiry_Main_Update_UPD1_10_TX.ktr

 






