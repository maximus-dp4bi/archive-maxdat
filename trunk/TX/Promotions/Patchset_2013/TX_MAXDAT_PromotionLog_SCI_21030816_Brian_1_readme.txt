***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB 
----------------
2013/08/16 B.Thai - Creation.

******************************************************************************************************

-----------------------
1. DB SCRIPTS SECTION
-----------------------
	-- Run these SQL scripts below as the the Oracle user MAXDAT:  
	-- (or as a proxy login to MAXDAT - Example: rk50472[maxdat])

	-- All files can be found at:					
	-- svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/SupportClientInquiry/patch
	-- or DB_SCI_20130816_BRIAN_1.zip

        20130816_1350_update_bast_sci_create_dt.sql

-----------------------
2. KETTLE FILES SECTION
-----------------------
Download AS_SCI_20130816_BRIAN_1.zip
and deploy to <MAXDAT_ETL_PATH> /SupportClientInquiry directory

svn://rcmxapp1d.maximus.com/maxdat/trunk/corp/scripts/SupportClientInquiry/
ClientInquiry_Child_RUNALL.kjb

svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/ETL/scripts/SupportClientInquiry/
ClientInquiry_Main_Insert_Rules_TX.ktr



