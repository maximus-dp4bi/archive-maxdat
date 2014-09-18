***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB EMRS
----------------
2013/09/20 A.Antonio - Creation.

******************************************************************************************************


-----------------------
1. DB SCRIPTS SECTION
-----------------------
	-- Run these SQL scripts below as the the Oracle user MAXDAT:  
	-- (or as a proxy login to MAXDAT - Example: rk50472[maxdat])

	-- All files can be found at:					
	-- svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/EMRS/patch
	-- or DB_EMRS_20130920_ARLENE_6.zip

	20130920_0938_cleanup_client_elig_data.sql
	

-----------------------
2. UNIX SCRIPT SECTION
-----------------------

DOwnload AS_EMRS_20130920_ARLENE_10.zip and
to <MAXDAT_ETL_PATH> directory

svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/ETL/scripts/
tx_emrs_init_partialload.sh

Run dos2unix for the following List 
	tx_emrs_init_partialload.sh

chmod 755 tx_emrs_init_partialload.sh
