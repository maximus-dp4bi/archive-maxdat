***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB 
----------------
2013/09/06 Mayuresh Bhalekar - Creation.

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
		--svn://rcmxapp1d.maximus.com/maxdat/BPM/TXEB/ManageJobs/patch/20130905_1259_Alter_ManageJobs_Scripts.sql
		--svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/ManageJobs/createdb/MANAGE_JOBS_pkg.sql

		-- or DB_MJ_20130906_MAYURESH_2.zip
	
	       		20130905_1259_Alter_ManageJobs_Scripts.sql
                MANAGE_JOBS_pkg.sql


	
	1.3 - Start BPM jobs:

		execute PROCESS_BPM_QUEUE_JOB_CONTROL.STARTUP_JOBS;

       
