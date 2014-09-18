***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB 
----------------
2013/09/19 Dave Dillon - Creation.

******************************************************************************************************

-----------------------
1. DB SCRIPTS SECTION
-----------------------
	-- Shut off Jobs
        execute PROCESS_BPM_QUEUE_JOB_CONTROL.SHUTDOWN_JOBS;

	-- Run these SQL scripts below as the the Oracle user MAXDAT:  
	-- (or as a proxy login to MAXDAT - Example: rk50472[maxdat])

	-- File can be found at:		
	-- svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/ManageWork/createdb/
	-- or DB_MW_20130919_DAVE_1.zip

        truncate_data_model_CORP_ETL_MANAGE_WORK.sql

	-- File can be found at:		
	-- svn://rcmxapp1d.maximus.com/maxdat/BPM/TXEB/ManageWork/createdb
	-- or DB_MW_20130919_DAVE_1.zip

        Reset_MW_PROCESSED_flag.sql

	-- File can be found at:		
	-- svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/ManageWork/createdb/
	-- or DB_MW_20130919_DAVE_1.zip

        create_ETL_ManageWork_views.sql

	-- Turn Jobs back on
        execute PROCESS_BPM_QUEUE_JOB_CONTROL.STARTUP_JOBS;

	   
	
-----------------------
2. KETTLE FILES SECTION
-----------------------

	-- No Kettle Changes
