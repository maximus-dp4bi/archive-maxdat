Author: D Dillon
Date  : Nov 15, 2013
Descr : This is a script that will remove logs from the log directory after the limit set in the env file
          and any logs that are 0 in size
******************************************************************************************************

-----------------------
1. DB SCRIPTS SECTION
-----------------------
	-- None


-----------------------
2. KETTLE FILES SECTION
-----------------------
Download AS_UTILITY_20131115_DAVE_1.zip
	(Files from svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/ETL/scripts/)

Perform the following commands based on target environment:
UAT
	1) DEPLOY the following files TO PATH: /dtxe4t/ETL_Scripts/scripts/
		purge_logs.sh
		tx_set_env_uat.txt

	2) Execute: mv tx_set_env_uat.txt .set_env

	3) Execute: dos2unix -o purge_logs.sh tx_purge_logs.sh

	4) Execute: chmod +x tx_purge_logs.sh


ProdSupport 
	1) DEPLOY the following files TO PATH: /ttxe4t/3rdparty/ETL_Scripts/scripts/
		purge_logs.sh
		tx_set_env_fix.txt

	2) Execute: mv tx_set_env_fix.txt .set_env

	3) Execute: dos2unix -o purge_logs.sh tx_purge_logs.sh

	4) Execute: chmod +x tx_purge_logs.sh

	5) Execute: /ptxe4t/ETL_Scripts/scripts/tx_purge_logs.sh

	6) To validate, run this command which should return no results:
		find /ttxe4t/3rdparty/ETL_Logs/logs \( -ctime +30 -o -size 0 \) -exec ls -l '{}' \; 

PRODUCTION 
	1) DEPLOY the following files TO PATH: /ptxe4t/ETL_Scripts/scripts/
		purge_logs.sh
		tx_set_env_prd.txt

	2) Execute: mv tx_set_env_prd.txt .set_env

	3) Execute: dos2unix -o purge_logs.sh tx_purge_logs.sh

	4) Execute: chmod +x tx_purge_logs.sh

	5) create the following cron job
		00 06 * * * /ptxe4t/ETL_Scripts/scripts/tx_purge_logs.sh

