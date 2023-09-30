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
	-- svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/ManageWork/patch
	-- or DB_MW_20130925_BRIAN_3.zip

        20130924_1548_recompile_MW_step_VW_add_ref_type.sql
        20130924_1831_update_MW_null_ref_type.sql


        execute PROCESS_BPM_QUEUE_JOB_CONTROL.STARTUP_JOBS;

 






