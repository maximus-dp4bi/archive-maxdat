***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB 
----------------
2013/11/4 B.Thai - Creation.

******************************************************************************************************

-----------------------
1. DB SCRIPTS SECTION
-----------------------

        execute PROCESS_BPM_QUEUE_JOB_CONTROL.SHUTDOWN_JOBS;

	-- Run these SQL scripts below as the the Oracle user MAXDAT:  
	-- (or as a proxy login to MAXDAT - Example: rk50472[maxdat])

	-- All files can be found at:
	-- svn://rcmxapp1d.maximus.com/maxdat/BPM/TXEB/SupportClientInquiry/patch
	-- or DB_SCI_20131104_BRIAN_7.zip

        20131031_1356_sci_retro_semantic.sql

        execute PROCESS_BPM_QUEUE_JOB_CONTROL.STARTUP_JOBS;


 






