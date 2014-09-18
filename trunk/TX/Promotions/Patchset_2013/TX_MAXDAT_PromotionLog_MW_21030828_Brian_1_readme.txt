***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB 
----------------
2013/08/28 B.Thai - Creation.

******************************************************************************************************

-----------------------
1. DB SCRIPTS SECTION
-----------------------
	-- Run these SQL scripts below as the the Oracle user MAXDAT:  
	-- (or as a proxy login to MAXDAT - Example: rk50472[maxdat])

        -- Stop BPM queue
        execute PROCESS_BPM_QUEUE_JOB_CONTROL.SHUTDOWN_JOBS;

	-- All files can be found at:		
	-- svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/ManageWork/patch/			
	-- svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/ManageWork/createdb/
	-- or DB_MW_20130828_BRIAN_1.zip

        20130816_1350_update_bast_sci_create_dt.sql
        MANAGE_WORK_pkg.sql

        -- Restart BPM queue
        execute PROCESS_BPM_QUEUE_JOB_CONTROL.STARTUP_JOBS;





