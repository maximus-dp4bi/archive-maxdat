***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB 
----------------
2013/08/19 Sumi - Creation.

******************************************************************************************************

-----------------------
1. DB SCRIPTS SECTION
-----------------------


	-- Run these below as the the Oracle user MAXDAT:
	-- (or as a proxy login to MAXDAT - Example: rk50472[maxdat])

	1.1 - Stop BPM jobs:

		execute PROCESS_BPM_QUEUE_JOB_CONTROL.SHUTDOWN_JOBS;

	1.2 Deploy files:

		-- All files can be found at:					
		-- svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/ManageMailFaxDoc/createdb/MANAGE_MAIL_FAX_DOC_pkg.sql

		-- svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/ManageMailFaxDoc/patch/20130816_1143_mailfaxdoc_refresh_jeop_timely_age.sql
	-- or DB_MFDOC_20130820_Sumi_1

        	MANAGE_MAIL_FAX_DOC_pkg.sql

		20130816_1143_mailfaxdoc_refresh_jeop_timely_age.sql


	1.3 - Start BPM jobs:

		execute PROCESS_BPM_QUEUE_JOB_CONTROL.STARTUP_JOBS;

