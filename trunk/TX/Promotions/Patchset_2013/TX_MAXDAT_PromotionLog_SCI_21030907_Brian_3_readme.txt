***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB 
----------------
2013/09/07 B.Thai - Creation.

******************************************************************************************************

-----------------------
1. DB SCRIPTS SECTION
-----------------------
	-- Run these SQL scripts below as the the Oracle user MAXDAT:  
	-- (or as a proxy login to MAXDAT - Example: rk50472[maxdat])

	-- All files can be found at:		
	-- svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/SupportClientInquiry/patch
	-- or DB_SCI_20130907_BRIAN_3.zip

        20130907_1147_reset_SCI_ctl_last_contact_id.sql
        truncate_data_model_CLIENT_INQUIRY.sql

        Acceptable errors from second script:
drop table BIA_BACKUP
ORA-00942: table or view does not exist
 
drop table BPM_UPDATE_EVENT_TEMP
ORA-00942: table or view does not exist
 
drop table BPM_UPDATE_EVENT_BACKUP

ORA-00942: table or view does not exist


------------------------------
2. Support Client Inquiry kettle files
------------------------------
Download AS_SCI_20130907_BRIAN_3
and deploy to <MAXDAT_ETL_PATH> /SupportClientInquiry directory

svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/ETL/scripts/SupportClientInquiry/
ClientInquiry_Child_Update_UPD1_20_TX.ktr
 






