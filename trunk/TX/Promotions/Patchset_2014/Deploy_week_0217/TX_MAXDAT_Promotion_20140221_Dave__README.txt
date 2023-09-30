***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB  Promotions week of 02/27/2014
----------------
Date       Developer           PHONE         Reason/Description
---------- ------------------- ------------- ------------------------------------------------------
2014/02/21 D. Dillon          512-757-4558  Promotion of Maxdat Statistics Package
***** MODIFICATION HISTORY ****************************************************************************

-----------------------
1. DB SCRIPTS SECTION
-----------------------
**SEND LOGS FOR ALL DB SCRIPTS **
** Run these SQL scripts below as the the Oracle user MAXDAT
 
       *******************************************************************************************	
        D.Dillon Maxdat Statistics
        ------------------------------------------------------------------------------------
	** Unzip DB_MAXDAT_STATISTICS_20140221_Dave_1.zip
        ** Run in the order specified below.

        1. GATHER_STATS_TABLE_CONFIG.sql
	2. populate_GATHER_STATS_TABLE_CONFIG.sql
	3. MAXDAT_STATISTICS_pkg.sql
        
        ------------------------------------------------------------------------------------
       *******************************************************************************************

Execute the following in SQL:

Begin
  maxdat_statistics.create_stats_job;
end;

-----------------------
2. KETTLE FILES SECTION
-----------------------
None