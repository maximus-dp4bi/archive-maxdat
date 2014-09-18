***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB 
----------------
2013/08/23 Mayuresh Bhalekar - Creation.

******************************************************************************************************

-----------------------
1. DB SCRIPTS SECTION
-----------------------


	-- Run these below as the the Oracle user MAXDAT:
	-- (or as a proxy login to MAXDAT - Example: rk50472[maxdat])

	1.1 - Stop BPM jobs:

		execute PROCESS_BPM_QUEUE_JOB_CONTROL.SHUTDOWN_JOBS;

	1.2 Deploy files:

		-- Run these SQL scripts below as the the Oracle user MAXDAT:  
		-- (or as a proxy login to MAXDAT - Example: rk50472[maxdat])

		-- All files can be found at:					
		-- svn://rcmxapp1d.maximus.com/maxdat/BPM/TXEB/ManageJobs/patch/
		-- or DB_MJ_20130823_MAYURESH_1.zip
	
	       		20130823_1055_truncate_data_model_MANAGE_JOBS.sql
	
	1.3 - Start BPM jobs:

		execute PROCESS_BPM_QUEUE_JOB_CONTROL.STARTUP_JOBS;

       





