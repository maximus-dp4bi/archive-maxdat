***** MODIFICATION HISTORY ****************************************************************************
Instructions to replace run_bpm 
----------------
Nov 21 2013 Dave Dillon - Creation.

******************************************************************************************************

-----------------------
1. DB SCRIPTS SECTION
-----------------------
	-- None


-----------------------
2. UNIX SCRIPTS SECTION
-----------------------
1) Stop the cron running cron_tx_run_bpm.sh

2) Download AS_ShellScripts_20131121_DAVE_1.zip
	(Files from svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/ETL/scripts)

3) Deploy the follow file to the appropriate path
UAT         DEPLOY TO PATH: /dtxe4t/ETL_Scripts/scripts

ProdSupport DEPLOY TO PATH: /ttxe4t/ETL_Scripts/scripts
	(The scripts directory is in the wrong place - the physical location as of 11/8 is: /ttxe4t/3rdparty/ETL_Scripts/scripts)

PRODUCTION DEPLOY TO PATH: /ptxe4t/ETL_Scripts/scripts


         tx_run_bpm.sh

4) Execute the following commands
	dos2unix -o tx_run_bpm.sh tx_run_bpm.sh
	chmod +x tx_run_bpm.sh

5) Kill any Client Outreach subroutines that might be running
	ps -ef | grep Client

6) Remove the checkfie if it exists
	rm $MAXDAT_ETL_PATH/TX_run_check.txt

7) Restart the cron job from Step 1