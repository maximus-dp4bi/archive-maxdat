***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB 
----------------
2013/10/18 B.Thai - Creation.

******************************************************************************************************

-----------------------
1. DB SCRIPTS SECTION
-----------------------

        execute PROCESS_BPM_QUEUE_JOB_CONTROL.SHUTDOWN_JOBS;

	-- Run these SQL scripts below as the the Oracle user MAXDAT:  
	-- (or as a proxy login to MAXDAT - Example: rk50472[maxdat])

	-- All files can be found at:
	-- svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/SupportClientInquiry/createdb
	-- svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/SupportClientInquiry/patch
	-- or DB_SCI_20131018_BRIAN_6.zip

        create_ETL_SupportClientInquiry_triggers.sql
        20131018_1340_SCI_update_null_aspb_created_by.sql

        execute PROCESS_BPM_QUEUE_JOB_CONTROL.STARTUP_JOBS;


------------------------------
2. Support Client Inquiry kettle files
------------------------------
Download AS_SCI_20131018_BRIAN_6
and deploy to <MAXDAT_ETL_PATH> /SupportClientInquiry directory

svn://rcmxapp1d.maximus.com/maxdat/trunk/Corp/scripts/SupportClientInquiry/
    ClientInquiry_Child_Insert_INS1_30.ktr
    ClientInquiry_Child_Update_UPD2_10.ktr
    ClientInquiry_Child_Update_UPD2_20.ktr
    ClientInquiry_Child_Update_UPD1_30.ktr

svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/ETL/scripts/SupportClientInquiry/
    ClientInquiry_Main_Insert_Rules_TX.ktr
    ClientInquiry_Main_Update_UPD1_10_TX.ktr



 






